udata = LOAD '/pig/u.data' as (userid:int, itemid:int, rating:int, timestamp:chararray);

uitem = LOAD '/pig/u.item' using PigStorage('|') as (movieid:int, movietitle:chararray, releasedate:chararray, imdburl:chararray);

result = JOIN udata by itemid, uitem by movieid;

filter1 = FILTER result BY (result.movieid == 376) OR (result.movieid == 495);

grouped = GROUP filter1 BY itemid;

finalresult = FOREACH grouped GENERATE filter1.movieid, filter1.movietitle, filter1.releasedate, filter1.imdburl, AVG(filter1.rating);

DUMP finalresult;
