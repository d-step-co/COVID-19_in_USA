create database demo;

create schema covid;

create table demo.covid.stats
(
  json_data         jsonb   	null
, meta_timestamp    timestamp	null
);

create table demo.covid.population
(
  state       	varchar(250)    null
, population    int             null
);

insert into demo.covid.population (state, population)
values
    ('Alabama', 4802740),
    ('Alaska', 722718),
    ('Arizona', 6482505),
    ('Arkansas', 2937979),
    ('California', 37691912),
    ('Colorado', 5116769),
    ('Connecticut', 3580709),
    ('Delaware', 907135),
    ('Florida', 19057542),
    ('Georgia', 9815210),
    ('Hawaii', 1374810),
    ('Idaho', 1584985),
    ('Illinois', 12869257),
    ('Indiana', 6516922),
    ('Iowa', 3062309),
    ('Kansas', 2871238),
    ('Kentucky', 4369356),
    ('Louisiana', 4574836),
    ('Maine', 1328188),
    ('Maryland', 5828289),
    ('Massachusetts', 6587536),
    ('Michigan', 9876187),
    ('Minnesota', 5344861),
    ('Mississippi', 2978512),
    ('Missouri', 6010688),
    ('Montana', 998199),
    ('Nebraska', 1842641),
    ('Nevada', 2723322),
    ('New Hampshire', 1318194),
    ('New Jersey', 8821155),
    ('New Mexico', 2082244),
    ('New York', 19465197),
    ('North Carolina', 9656401),
    ('North Dakota', 683932),
    ('Ohio', 11544951),
    ('Oklahoma', 3791508),
    ('Oregon', 3871859),
    ('Pennsylvania', 12742886),
    ('Rhode Island', 1051302),
    ('South Carolina', 4679230),
    ('South Dakota', 824082),
    ('Tennessee', 6403353),
    ('Texas', 25674681),
    ('Utah', 2817222),
    ('Vermont', 626431),
    ('Virginia', 8096604),
    ('Washington', 6830038),
    ('West Virginia', 1855364),
    ('Wisconsin', 5711767),
    ('Wyoming', 568158);
