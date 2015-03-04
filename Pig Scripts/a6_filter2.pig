udata = LOAD '/pig/u.data' as (userid:int, itemid:int, rating:int, timestamp:chararray);

filter1 = FILTER udata BY udata.itemid == 376 OR udata.itemid == 495;

uitem = LOAD '/pig/u.item' using PigStorage('|') as (movieid:int, movietitle:chararray, releasedate:chararray, imdburl:chararray);

result = JOIN filter1 by itemid, uitem by movieid;

DUMP result;
