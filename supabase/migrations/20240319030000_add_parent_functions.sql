-- Function to get upcoming sessions for a parent's students
create or replace function get_parent_upcoming_sessions(p_parent_id uuid)
returns table (
    session_id uuid,
    student_id uuid,
    tutor_id uuid,
    title text,
    scheduled_at timestamptz,
    status text
)
language sql
security definer
set search_path = public
as $$
    select 
        cs.id as session_id,
        sca.student_id,
        cs.tutor_id,
        cs.title,
        cs.scheduled_at,
        case 
            when cs.scheduled_at < now() then 'completed'
            else 'scheduled'
        end as status
    from class_sessions cs
    inner join student_class_attendance sca on sca.session_id = cs.id
    inner join user_profiles up on up.id = sca.student_id
    inner join students s on s.id = up.id
    where s.parent_id = p_parent_id
    and cs.scheduled_at > now()
    order by cs.scheduled_at asc;
$$;

-- Function to get billing statistics for a parent
create or replace function get_parent_billing_stats(p_parent_id uuid)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    stats json;
begin
    select json_build_object(
        'total_spent', coalesce(sum(amount) filter (where status = 'paid'), 0),
        'pending_payments', count(*) filter (where status = 'pending'),
        'student_count', (select count(*) from students where parent_id = p_parent_id)
    )
    into stats
    from billing b
    where b.parent_id = p_parent_id;

    return stats;
end;
$$;

-- Function to get recent activities for a parent
create or replace function get_parent_recent_activities(p_parent_id uuid)
returns json
language plpgsql
security definer
set search_path = public
as $$
declare
    activities json;
begin
    with recent_events as (
        -- Sessions
        select 
            cs.created_at as timestamp,
            'session' as type,
            json_build_object(
                'title', cs.title,
                'student_id', sca.student_id,
                'tutor_id', cs.tutor_id,
                'student_name', up.full_name,
                'tutor_name', tp.full_name,
                'status', case 
                    when cs.scheduled_at < now() then 'completed'
                    else 'scheduled'
                end
            ) as details
        from class_sessions cs
        inner join student_class_attendance sca on sca.session_id = cs.id
        inner join user_profiles up on up.id = sca.student_id
        inner join user_profiles tp on tp.id = cs.tutor_id
        inner join students s on s.id = up.id
        where s.parent_id = p_parent_id
        
        union all
        
        -- Payments
        select 
            b.created_at,
            'payment' as type,
            json_build_object(
                'amount', b.amount,
                'status', b.status,
                'student_id', b.student_id,
                'student_name', up.full_name,
                'due_date', b.due_date,
                'invoice_url', b.invoice_url
            ) as details
        from billing b
        inner join user_profiles up on up.id = b.student_id
        where b.parent_id = p_parent_id
        
        union all
        
        -- Learning Insights Updates
        select 
            li.created_at as updated_at,
            'progress' as type,
            json_build_object(
                'student_id', li.student_id,
                'student_name', up.full_name,
                'type', li.insight_type,
                'value', li.value
            ) as details
        from learning_insights li
        inner join user_profiles up on up.id = li.student_id
        inner join students s on s.id = up.id
        where s.parent_id = p_parent_id
    )
    select json_agg(
        json_build_object(
            'timestamp', timestamp,
            'type', type,
            'details', details
        )
        order by timestamp desc
    )
    into activities
    from recent_events
    where timestamp > now() - interval '30 days'
    limit 20;

    return coalesce(activities, '[]'::json);
end;
$$;
