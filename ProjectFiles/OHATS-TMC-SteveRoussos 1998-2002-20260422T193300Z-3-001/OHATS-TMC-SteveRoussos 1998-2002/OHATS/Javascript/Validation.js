// JScript File
function fnValidateAttachmentType(source, arguments)
{   
    var fileName = arguments.Value;
    var argLength = eval(fileName.length);
    var startIndex = eval(argLength - 3);
    var fileType = fileName.substring(eval(startIndex),eval(startIndex+3));
    
    if((fileType == "txt") || (fileType == "doc") || (fileType == "ppt"))
    {
        arguments.IsValid = true;
        return true;
    }
    else
    {
        arguments.IsValid = false;
        return false;
    }   
}


function isAlphanumeric(source, arguments)
{
    if(isAlphanumeric1(arguments.Value,true))
    {
        arguments.IsValid = true;
        return true;
    }
    else
    {
        arguments.IsValid = false;
        return false;
    }   


}


function isAlphabetic1(strValue,isSpaceRequired)
{
    var s,i;
	var val = strValue;
	var len = val.length;
	if(isSpaceRequired)
	{
	    for(i=0; i<len;i++)
	    {
			s = val.charCodeAt(i);
			if(!((s >= 65 && s <=90) || (s >=97 && s <=122)|| (s == 32)))
				return false;
		}		
        return true;
    }
    else
    {
     for(i=0; i<len;i++)
	    {
			s = val.charCodeAt(i);
			if(!((s >= 65 && s <=90) || (s >=97 && s <=122)))
				return false;
		}		
        return true;
    }
}


function isAlphanumeric1(strVal)
{

var pos;
		for (pos=0;pos<strVal.length;pos++)
			{
				if (strVal.charCodeAt(pos) != 32)
					{
						if ((strVal.charCodeAt(pos) > 90 && strVal.charCodeAt(pos) < 97) || strVal.charCodeAt(pos)< 65 || strVal.charCodeAt(pos)> 122)
							return false;
					}
			}
		return true;
		
		
}
function isValidNumeric(source, arguments)
{
    if(isNumber(arguments.Value))
    {
        arguments.IsValid = true;
        return true;
    }
    else
    {
        arguments.IsValid = false;
        return false;
    }   
}

        function isNumber(objValue)
        {
	        var strField = objValue;
	        var i = 0;

	        for (i = 0; i < strField.length; i++)
		    if (strField.charAt(i) < '0' || strField.charAt(i) > '9') 
		    {
			    return false;
		    }

	        return true;
        }
        
  /*None of the date Selected means*/         
function None(source, args)
  {
    var vTextBox1 = document.getElementById('ctl00_Main_txtFromDate');
    var vTextBox2 = document.getElementById('ctl00_Main_txtDateUnsure ');
    if ((vTextBox1.value == "")&&(vTextBox2.value == ""))
    {
      args.IsValid = false;
      return false;
      }
   
    else
    {
       args.IsValid = true;
       return true; 
    }
 }

function NoneOrBoth(sender, args)
{
   var vTextBox1 = document.getElementById('_ctl0:Main:wizard:_ctl13:txtEventOccureddate');
   var vTextBox2 = document.getElementById('_ctl0_Main_wizard__ctl13_txtDateUnsurred');
   if ((vTextBox1.value != "") && (vTextBox2.value == ""))
     args.IsValid = false;
   else if ((vTextBox1.value != "") && (vTextBox2.value != ""))
     args.IsValid = true;
   else
     args.IsValid = true;

}

        
function isValidEmail(source, arguments)
{
    if(fnEmailIdValidity1(arguments.Value))
    {
        arguments.IsValid = true;
        return true;
    }
    else
    {
        arguments.IsValid = false;
        return false;
    }   
}
 function fnEmailIdValidity1(obj)
	{
		var locAt=0;
		var locDot=0;
		var flagAt=0;
		var flagDot=0;
		var cntAt=0;
		var cntDot=0;

		for (i=0;i<obj.length;i++)
		{
			s =  obj.charCodeAt(i)
			if (i==0 || i==obj.length-1)
			{
				if ((s ==45) || (s==95))
				{
					return false;
				} 
			}
			cndt=(s >=48 && s <= 57) || (s>=65 && s<=90) || (s>=97 && s<=122) || (s==64) || (s==46) || (s==95) || (s==45)
			if (!(cndt))
			{
				return false;
			}
			s1=obj.substr(i,1)
			if (s1=='@')
			{
				cntAt=cntAt+1
				locAt=i
			}
			if (s1=='.')
			{
				cntDot=cntDot+1
				locDot=i
			}
			if (cntAt >1)
			{
				return false;
			}        
		}
		s2=obj.charCodeAt(locAt+1)
		s3=obj.charCodeAt(locAt-1)
		s=s2
		cndtBef=(s >= 48 && s <= 57) || (s>=65 && s<=90) || (s>=97 && s<=122) 
		s=s3
		cndtAft=(s >= 48 && s <= 57) || (s>=65 && s<=90) || (s>=97 && s<=122) 
		if (cndtBef && cndtAft)
		{
		flagAt=1
		}
		s2=obj.charCodeAt(locDot+1)
		s3=obj.charCodeAt(locDot-1)
		s=s2
		cndtBef=(s >= 48 && s <= 57) || (s>=65 && s<=90) || (s>=97 && s<=122) 
		s=s3
		cndtAft=(s >= 48 && s <= 57) || (s>=65 && s<=90) || (s>=97 && s<=122) 
		if (cndtBef && cndtAft)
		{
			flagDot=1 
		}
			
		if (flagAt==1 && flagDot==1)
			{
			return true;
			}
		else
		{
			return false;
		}		
	}	


function IsSelected(source, arguments)
{
    if(arguments.Value > 0)
    {
        arguments.IsValid = true;
        return true;
    }
    else
    {
        arguments.IsValid = false;
        return false;
    }   
}




function alphanumeric(alphane)
{
	var numaric = alphane;
	for(var j=0; j<numaric.length; j++)
		{
		  var alphaa = numaric.charAt(j);
		  var hh = alphaa.charCodeAt(0);
		  if((hh > 47 && hh<59) || (hh > 64 && hh<91) || (hh > 96 && hh<123))
		  {
		  }
		else	{
			 return false;
		  }
		}
 return true;
}



