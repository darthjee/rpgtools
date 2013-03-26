var Dices = {
    roll : function(dice){
        return Math.floor(Math.random()*dice)+1;
    }
}

$(function(){
    function calcAvarage(config)
    {
        var settings = $.maskExtend({
            ndices:4,
            dicesSum:3,
            minvalue:10,
            dsize:6
        }, config);
        with(settings){
            dicesSum = dicesSum <= ndices ? dicesSum : ndices;
            minvalue = minvalue > dicesSum ? minvalue : dicesSum;
            var dicesRemoved = ndices - dicesSum;
            var dices = new Array(ndices);
            var rolls = [];

            for (var i = 0; i <= dicesSum*(dsize-1); i++)
                rolls[i] = 0;

            function roll(index){
                if (index){
                    for (var i = 1; i <= dsize; i++){
                        dices[index-1] = i
                        roll(index-1);
                    }
                } else {
                   arr = dices.filter(function(){return true}).sort()
                     .slice(dicesRemoved);
                   var sum = 0;
                   while (arr.length){
                       sum += arr.pop();
                   }
                   if (sum >= minvalue){
                       rolls[sum-ndices+1]++;
                   }
                }
            }

            roll(ndices);
            var sum = 0;
            var count = 0;
            for (i = minvalue-dicesSum; i <rolls.length; i++)
            {
                sum += (i+dicesSum)*rolls[i];
                count += rolls[i];
            }
            console.info(sum, count, rolls);

            return sum/count;
        }
    }

    var ava = calcAvarage({
        ndices:4,
        dicesSum:3,
        minvalue:10
      });
    $('.content').text(ava);
});
