select
    sum((s.json_data ->> 'Confirmed')::int) as total_confirmed
  , sum((s.json_data ->> 'Deaths')::int) as total_deaths
  , (sum((s.json_data ->> 'Confirmed')::int) / sum(p.population::float) * 100)::numeric(38,2) as affested_share
  , (sum((s.json_data ->> 'Deaths')::int) / sum((s.json_data ->> 'Confirmed')::float) * 100)::numeric(38,2) as mortality_rate
from
    {{ source('covid', 'stats')}} s
inner join
    {{ source('covid', 'population')}} p
    on (s.json_data ->> 'Province')::varchar = p.state