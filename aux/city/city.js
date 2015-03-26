/**
 * @brief creates a matrix
 * @param arr: array of dimensions
 * @param def: default value
 * @return
 */
function createMatrix(arr, def)
{
  if (def === null)
    def = 0;
  var matrix = def;
  if (arr.length > 0)
  {
    var dim = arr.shift();
    matrix = [];
    for (var i = 0; i < dim; i++)
      matrix[i] = createMatrix(arr,def);
    arr.unshift(dim);
  }
  return matrix;
}

/************************************************************************/

/**
 * @brief checks teh type of the city to be calculated
 */
function getTypeCalc()
{
  return $("input[name='typeCalc']:radio:checked:eq(0)").val();
}
/**************************************************************************/
/**
 * @brief create a new class in the table#list
 * @param f
 * @param name
 * @param val
 * @return
 */
function createClass(f, name, val)
{
  if (f.length > 0 && name.length > 0)
  {
    if (jQuery('div#classes table#list label[for="'+f+'"]').length > 0)
    {
      jQuery('div#classes table#list label[for="'+f+'"]').text(name+" ("+f+")");
    }
    else
    {
      var html = '<tr><td><label for="'+f+'">'+name+' ('+f+')</label></td><td><input name="'+f+'" id="'+f+'" type="text" value=""/></td><td class="remove">x</td></tr>';
      jQuery('div#classes table#list').append(html);
    }
    jQuery('div#classes table#list input#'+f).val(val);
  }
}

/**************************************************************************/
jQuery('input#create').live("click",
  /**
   * @brief function to be called on the click of create a class.
   * it calls for @ref createClass
   */
  function addClass()
  {
    var f = jQuery('input#newLabel').val();
    var name = jQuery('input#newName').val();
    var val = jQuery('input#newValue').val();
    createClass(f, name, val);
  });



/************************************************************************/
jQuery('input#export').live("click",
  function exportClass()
  {
    jQuery('textarea#parser').val("");
    var text = "";
    jQuery('div#classes table#list tr').each(
      function ()
      {
        var row = jQuery(this);
        var classe = row.find('td:first').text();
        var levels = row.find('td:eq(1) input').val();
        text += classe+':'+levels+"\n";
      });
    jQuery('textarea#parser').val(text);
  });



/************************************************************************/
jQuery('input#parse').live("click",
  function parseClass()
  {   
    lines = jQuery('textarea#parser').val().split('\n');
    for (var i = 0; i < lines.length; i++)
    {
      lines[i] = lines[i].replace(/ /g, "");
      var line = lines[i].split(':');
      var name = (function getName(str)
      {
        return str.replace(/^([a-zA-Z0-9 ]*)[(][a-zA-Z0-9]*[)]/g, '$1');
      })(line[0]);
      var abrev = (function getShort(str)
      {
        if (str.match(/[(][a-zA-Z0-9]*[)]/g, '$1'))
          rtn = str.replace(/^[a-zA-Z0-9 ]*[(]([a-zA-Z0-9]*)[)]/g, '$1');
        else
        {
          var rtn = str.substring(0,3);
          if (jQuery('div#classes table#list label[for="'+rtn+'"]').length > 0 
              && jQuery('div#classes table#list label[for="'+rtn+'"]').text() != str+' ('+rtn+')')
            abrev = rtn.substring(0,4);
        }
        return rtn;
      })(line[0]);
      var value = line[1];

      createClass(abrev, name, value);
    }
    
    if (jQuery('input#autoCalc:checked').length > 0)
      jQuery('input#calculate').get()[0].click();
      
  });


/************************************************************************/
jQuery('input#calculate').live("click",
  /**
   * @brief Calculate the number of chars in each class for all the levels
   * @return
   */
  function calcAll()
  {
    var list = {};
    /* header creation */
    jQuery('div#table table').html("<tr><th></th></tr>");
    jQuery('div#classes table#list label').each(function grabClasseData()
    {
      var abrev = jQuery(this).attr('for');
      list[abrev] = jQuery('input#'+abrev).val().split(',');
    });
    /* dertermination of maximum level */
    var maxLevel = (function checkMax(list)
    {
      var max = 0;
      for (var abrev in list)
      {
        for (var i = 0; i < list[abrev].length; i++)
        {
          var n = Number(list[abrev][i]);
          if (n > max)
            max = n;
        }
      }
      return max;
    })(list);

    /* creation of header with all classes */
    for (var abrev in list)
      jQuery('div#table table tr').append("<th>"+abrev+"</th>");
    /* creation of rows */
    for (var i = 0; i < maxLevel; i++)
    {
      jQuery('div#table table').append("<tr><th>"+(i+1)+"</th></tr>");
      for (abrev in list)
        jQuery('div#table table tr:last').append("<td></td>");
    }
    
    /* creation of the variable matrix */
    var matrix = (function calcMatrix(maxLevel, list)
    {
      var nclass = jQuery('div#classes table#list label').length;
      var matrix = createMatrix([nclass,maxLevel], 0);
      var i = 0;
      for (var abrev in list)
      {
        for (var j = 0; j < list[abrev].length; j++)
        {
          level = list[abrev][j]-1;
          matrix[i][level]++;
        }
        for (var level = maxLevel; level > 1; level--)
        {
          var num = Number(matrix[i][level-1]);
          if (getTypeCalc() == "monster")
            var col = level - 3;
          else
            var col = (level/2).toFixed(0)-1;
          if (col < 0)
            col = 0;
          matrix[i][col] += 2*num;
        }
        i++;
      }
      return matrix;
    })(maxLevel, list);
    
    /* placing the data in the table */
    (function placeData(matrix)
    {
      jQuery('div#table table').append('<tr><th>Sum</th></tr><tr><th>Tot</th></tr>');
      var tot = 0;
      for (var i = 0; i < matrix.length; i++)
      {
        var sum = 0;
        for (var j = 0; j < matrix[i].length; j++)
        {
          var num = matrix[i][j];
          if (num > 0)
            jQuery('div#table table tr:eq('+(j+1)+') td:eq('+i+')').text(num);
          sum += num;
        }
        tot += sum;
        jQuery('div#table table tr:eq('+(j+1)+')').append('<td>'+sum+'</td>');
      }
      jQuery('div#table table tr:last').append('<td>'+tot+'</td>');
    })(matrix);
  });


/**********************************************************************/
jQuery('input#reset').live("click",
  function resetList()
  {
    jQuery('table#list').html("");
  });


/**********************************************************************/
jQuery('table#list td.remove').live("click",
  function resetList()
  {
    jQuery(this).parent().remove();
  });