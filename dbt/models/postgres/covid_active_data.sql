select
    p.state
  , (s.json_data ->> 'Active')::bigint * 1000 / p.population::int as active_per_1000
from
    {{ source('covid', 'stats')}} s
inner join
    {{ source('covid', 'population')}} p
    on (s.json_data ->> 'Province')::varchar = p.state