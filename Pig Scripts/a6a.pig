udata = LOAD '/pig/u.data' as (userid:int, itemid:int, rating:int, timestamp:chararray);

uitem = LOAD '/pig/u.item' using PigStorage('|') as (movieid:int, movietitle:chararray, releasedate:chararray,blank:chararray,imdburl:chararray);

result = JOIN udata by itemid, uitem by movieid;

grouped = GROUP result BY itemid;

finalresult = FOREACH grouped GENERATE result.movieid, result.movietitle, result.releasedate, result.imdburl, AVG(result.rating);

STORE finalresult into '/output';
