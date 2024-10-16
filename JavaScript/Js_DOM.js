function calculateInterest()
  {
     var principal=parseInt(document.getElementById("principal").value); 
     var rate=parseInt(document.getElementById("rate").value);
     var time= parseInt(document.getElementById("time").value);
     var error=" <div class=error> Error: Principal amount must be between 500 and 10000.</div>"
     let baserate='0';

     if (principal< 500 || principal > 10000) {
        document.getElementById("output").innerHTML=error;
        return;
      }

     if (principal < 1000) {
         baserate = 5;
       } 
     else if (principal >=1000 && principal <=5000) {
         baserate = 7;
       }
     else if (principal > 5000) {
         baserate = 10;
       }

     if(rate != baserate ){
        document.getElementById('note').innerHTML=
        "<div class=note>Please note: For principal amounts below $1,000, the rate is 5%. Between $1,000 and $5,000, the rate is 7%. Above $5,000, the rate is 10%."
      }

     else if(rate = baserate){
        var interest= principal*rate*time/100;
        var total= interest + principal;  
        document.getElementById("applied-rate").innerHTML=interest;
        document.getElementById("total-amount").innerHTML=total; 
        return;
       }

     if (time > 5) {
        rate =rate + 2;
        additionalinfo = 'An additional 2% interest rate has been added for time greater than 5 years.';
      }
      document.getElementById("additional-info").innerHTML= additionalinfo;

   }