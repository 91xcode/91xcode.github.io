new Vue({el:"#containerPayback",data:{money:490000,months:120,yearRate:6.37,paybackMode:2,billList:[],formula:{1:"等额本息：月供=贷款本金×[年化利率÷12×(1+年化利率÷12) ^ 还款月数]÷{[(1+年化利率÷12) ^ 还款月数]-1}",2:"等额本金：月供=贷款本金÷还款月数x(1+年化利率÷12x剩余还款期数)"},calcMode:"rate",calcModeText:{rate:"实际年化反推",loan:"月供账单计算"},revRate:0,revAllAmount:647366,revAllInterest:0},mounted:function(){this.paybackConvert()},methods:{paybackConvert:function(){this.$nextTick(()=>{this.dataCheck()&&("rate"===this.calcMode?1===parseInt(this.paybackMode)?this.avgCapitalPlusInterest():this.avgCapitalOnly():this.revCalcYearRate())})},dataCheck:function(){if(!this.money||!/\d|\./.test(this.money)||parseInt(this.money)<=0)return alert("请输入正确的贷款金额！"),!1;if(!this.months||/\D/.test(this.months)||parseInt(this.months)<=0)return alert("请输入正确的贷款期限！"),!1;if(parseInt(this.months)>360)return alert("在哪儿能贷30年？"),!1;if("rate"===this.calcMode){if(!this.yearRate||!/\d|\./.test(this.yearRate)||parseFloat(this.yearRate)<=0)return alert("请输入正确的贷款年化利率！"),!1}else{if(!this.revAllAmount||!/\d|\./.test(this.revAllAmount)||parseInt(this.revAllAmount)<=0)return alert("请输入正确的总还款额！"),!1;if(parseInt(this.revAllAmount)<parseInt(this.money))return alert("还款总额比贷款本金还低，这种情况就不用算了吧。。。"),!1}return!0},avgCapitalPlusInterest:function(){let t=this.yearRate/12/100,e=Math.pow(t+1,this.months),n=Math.round(this.money*t*e/(e-1)*100)/100,o=n*this.months,a=o-this.money,r=this.money,i=a,s=this.months,h=0,l=0;for(this.billList=[{name:"合计",amount:Number(this.money).toFixed(2),interest:(Math.round(100*a)/100).toFixed(2),bill:(Math.round(100*o)/100).toFixed(2),totalAmount:"-",totalInterest:"-",leftOver:(Math.round(100*r)/100).toFixed(2),leftInterest:(Math.round(100*a)/100).toFixed(2)}];s>0;s--)e=Math.pow(t+1,s||0),1===s?(h=i,l=r):l=n-(h=r*t),r-=l,i-=h,this.billList.push({name:`第${this.months-s+1}期`,amount:(Math.round(100*l)/100).toFixed(2),interest:(Math.round(100*h)/100).toFixed(2),bill:(Math.round(100*n)/100).toFixed(2),totalAmount:(Math.round(100*(this.money-r))/100).toFixed(2),totalInterest:(Math.round(100*(a-i))/100).toFixed(2),leftOver:(Math.round(100*r)/100).toFixed(2),leftInterest:(Math.round(100*i)/100).toFixed(2)})},avgCapitalOnly:function(){let t=this.yearRate/12/100,e=this.money/this.months,n=e*t,o=(e+this.money*t+e*(1+t))/2*this.months,a=o-this.money,r=this.money,i=a;this.billList=[{name:"合计",amount:Number(this.money).toFixed(2),interest:(Math.round(100*a)/100).toFixed(2),bill:(Math.round(100*o)/100).toFixed(2),totalAmount:"-",totalInterest:"-",leftOver:(Math.round(100*r)/100).toFixed(2),leftInterest:(Math.round(100*a)/100).toFixed(2)}];let s=0;for(let t=this.months;t>0;t--)r-=e,i-=s=t*n,this.billList.push({name:`第${this.months-t+1}期`,amount:(Math.round(100*e)/100).toFixed(2),interest:(Math.round(100*s)/100).toFixed(2),bill:(Math.round(100*(e+s))/100).toFixed(2),totalAmount:(Math.round(100*(this.money-r))/100).toFixed(2),totalInterest:(Math.round(100*(a-i))/100).toFixed(2),leftOver:(Math.round(100*r)/100).toFixed(2),leftInterest:(Math.round(100*i)/100).toFixed(2)})},exchange:function(){this.calcMode="rate"===this.calcMode?"loan":"rate",this.$nextTick(()=>{"rate"===this.calcMode?this.paybackConvert():this.revCalcYearRate()})},revCalcYearRate:function(){let t=[],e=(e,n)=>{let o=t[t.length-2];if(n){if(o[1]){for(let n=t.length-3;n>=0;n--)if(!t[n][1])return(e+t[n][0])/2;return e-2}return(e+o[0])/2}if(o[1])return(e+o[0])/2;for(let n=t.length-3;n>=0;n--)if(t[n][1])return(e+t[n][0])/2;return e+2},n=(t,e,n,o,a)=>{let r=n/12/100,i=0;if(1===a){let n=Math.pow(r+1,e);i=e*Math.round(t*r*n/(n-1)*100)/100}else i=(t/e+t*r+t/e*(1+r))/2*e;let s=Math.abs(i-o);return s>=0&&s<=(o-t)/t*e/12/.1374?[n]:i>o?[n,1]:[n,0]};this.revAllInterest=Math.round(100*(this.revAllAmount-this.money))/100,this.revRate=((o,a,r,i)=>{t=[[0,0],[0,0]];let s=(r-o)/o/a*12*100,h=n(o,a,s,r,i),l=0,u="unknown";for(;l<1e3;){if(l++,1===h.length){u=Math.round(100*h[0])/100+"％";break}t.push(h),s=e(h[0],h[1]),h=n(o,a,s,r,i)}return u})(this.money,this.months,this.revAllAmount,parseInt(this.paybackMode))}}});