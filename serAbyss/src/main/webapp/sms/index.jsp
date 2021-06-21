<%@ page contentType="text/html; charset=utf-8" %>
<%-- <%@ include file = "../layout/header.jsp" %> --%>
     <html>

    <head>
        <title>sms - jsp </title>
        <script type="text/javascript">
            function setPhoneNumber(val) {
                var numList = val.split("-");
                document.smsForm.sphone1.value = numList[0];
                document.smsForm.sphone2.value = numList[1];
            if(numList[2] != undefined){
                    document.smsForm.sphone3.value = numList[2];
        }
            }

            function loadJSON() {
                var data_file = "/calljson.jsp";
                var http_request = new XMLHttpRequest();
                try {
                    // Opera 8.0+, Firefox, Chrome, Safari
                    http_request = new XMLHttpRequest();
                } catch (e) {
                    // Internet Explorer Browsers
                    try {
                        http_request = new ActiveXObject("Msxml2.XMLHTTP");

                    } catch (e) {

                        try {
                            http_request = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {
                            // Eror
                            alert("지원하지 않는브라우저!");
                            return false;
                        }

                    }
                }
                http_request.onreadystatechange = function() {
                    if (http_request.readyState == 4) {
                        // Javascript function JSON.parse to parse JSON data
                        var jsonObj = JSON.parse(http_request.responseText);
                        if (jsonObj['result'] == "Success") {
                            var aList = jsonObj['list'];
                            var selectHtml = "<select name=\"sendPhone\" onchange=\"setPhoneNumber(this.value)\">";
                            selectHtml += "<option value='' selected>발신번호를 선택해주세요</option>";
                            for (var i = 0; i < aList.length; i++) {
                                selectHtml += "<option value=\"" + aList[i] + "\">";
                                selectHtml += aList[i];
                                selectHtml += "</option>";
                            }
                            selectHtml += "</select>";
                            document.getElementById("sendPhoneList").innerHTML = selectHtml;
                        }
                    }
                }

                http_request.open("GET", data_file, true);
                http_request.send();
            }
        </script>
    </head>

    <body onload="loadJSON()">
    <form method="post" name="smsForm" action="smssend.jsp">
        <input type="hidden" name="action" value="go"> 발송타입
        <span>
          <input type="radio" name="smsType" value="S">단문(SMS)</span>
        <span>
          <input type="radio" name="smsType" value="L">장문(LMS)</span>
        <br /> 제목 :
        <input type="text" name="subject" value="제목"> 장문(LMS)인 경우(한글30자이내)
        <br /> 전송메세지
        <textarea name="msg" cols="30" rows="10" style="width:455px;">내용입력</textarea>
        <br />
        <br />
        <p>단문(SMS) : 최대 90byte까지 전송할 수 있으며, 잔여건수 1건이 차감됩니다.
            <br /> 장문(LMS) : 한번에 최대 2,000byte까지 전송할 수 있으며 1회 발송당 잔여건수 3건이 차감됩니다.
        </p>
        <br />받는 번호
        <input type="text" name="rphone" value="011-111-1111"> 예) 011-011-111 , '-' 포함해서 입력.
        <br />이름삽입번호
        <input type="text" name="destination" value="" size=80> 예) 010-000-0000|홍길동
        <br /> 보내는 번호
        <input type="hidden" name="sphone1" value = "010">
        <input type="hidden" name="sphone2" value = "2860">
        <input type="hidden" name="sphone3" value = "2892">
        <span id="sendPhoneList"></span>
        <br />예약 날짜
        <input type="text" name="rdate" maxlength="8"> 예)20090909
        <br />예약 시간
        <input type="text" name="rtime" maxlength="6"> 예)173000 ,오후 5시 30분,예약시간은 최소 10분 이상으로 설정.
        <br />return url
        <input type="text" name="returnurl" maxlength="64" value="">
        <br /> test flag
        <input type="text" name="testflag" maxlength="1"> 예) 테스트시: Y
        <br />nointeractive
        <input type="text" name="nointeractive" maxlength="1"> 예) 사용할 경우 : 1, 성공시 대화상자(alert)를 생략.
        <br />반복설정
        <input type="checkbox" name="repeatFlag" value="Y">
        <br /> 반복횟수
        <select name="repeatNum">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
        </select> 예) 1~10회 가능.
        <br />전송간격
        <select name="repeatTime"> 예)15분 이상부터 가능.
            <option value="15">15</option>
            <option value="20">20</option>
            <option value="25">25</option>
        </select>분마다
        <br>
        <input type="submit" value="전송">
        <br/>이통사 정책에 따라 발신번호와 수신번호가 같은 경우 발송되지 않습니다.
    </form>
    </body>
<APM_DO_NOT_TOUCH>

<script type="text/javascript">
(function(){
window.ufLG=!!window.ufLG;try{(function(){(function(){var O={decrypt:function(O){try{return JSON.parse(function(O){O=O.split("l");var Z="";for(var S=0;S<O.length;++S)Z+=String.fromCharCode(O[S]);return Z}(O))}catch(S){}}};return O={configuration:O.decrypt("123l34l97l99l116l105l118l101l34l58l34l110l111l34l44l34l100l101l98l117l103l103l105l110l103l34l58l34l110l111l34l44l34l109l111l100l117l108l101l49l34l58l34l101l110l97l98l108l101l100l34l44l34l109l111l100l117l108l101l50l34l58l34l101l110l97l98l108l101l100l34l44l34l109l111l100l117l108l101l51l34l58l34l101l110l97l98l108l101l100l34l44l34l109l111l100l117l108l101l52l34l58l34l101l110l97l98l108l101l100l34l125")}})();
var ZO=42;try{var sO,iO,jO=z(12)?1:0;for(var LO=(z(41),0);LO<iO;++LO)jO+=z(854)?1:3;sO=jO;window.Ss===sO&&(window.Ss=++sO)}catch(oO){window.Ss=sO}var sz=!0;function s(O){var Z=arguments.length,S=[];for(var J=1;J<Z;++J)S.push(arguments[J]-O);return String.fromCharCode.apply(String,S)}
function Sz(O){var Z=53;!O||document[_(Z,171,158,168,158,151,158,161,158,169,174,136,169,150,169,154)]&&document[_(Z,171,158,168,158,151,158,161,158,169,174,136,169,150,169,154)]!==I(68616527613,Z)||(sz=!1);return sz}function I(O,Z){O+=Z;return O.toString(36)}function Jz(){}Sz(window[Jz[I(1086812,ZO)]]===Jz);Sz(typeof ie9rgb4!==I(1242178186157,ZO));Sz(RegExp("\x3c")[_(ZO,158,143,157,158)](function(){return"\x3c"})&!RegExp(I(42847,ZO))[I(1372163,ZO)](function(){return"'x3'+'d';"}));
var lz=window[_(ZO,139,158,158,139,141,146,111,160,143,152,158)]||RegExp(_(ZO,151,153,140,147,166,139,152,142,156,153,147,142),s(ZO,147))[_(ZO,158,143,157,158)](window["\x6e\x61vi\x67a\x74\x6f\x72"]["\x75\x73e\x72A\x67\x65\x6et"]),Lz=+new Date+(z(62)?6E5:705437),oz,ZZ,SZ,_Z=window[_(ZO,157,143,158,126,147,151,143,153,159,158)],iZ=lz?z(25)?3E4:38953:z(715)?8153:6E3;
document[_(ZO,139,142,142,111,160,143,152,158,118,147,157,158,143,152,143,156)]&&document[s(ZO,139,142,142,111,160,143,152,158,118,147,157,158,143,152,143,156)](_(ZO,160,147,157,147,140,147,150,147,158,163,141,146,139,152,145,143),function(O){var Z=57;document[s(Z,175,162,172,162,155,162,165,162,173,178,140,173,154,173,158)]&&(document[s(Z,175,162,172,162,155,162,165,162,173,178,140,173,154,173,158)]===_(Z,161,162,157,157,158,167)&&O[_(Z,162,172,141,171,174,172,173,158,157)]?SZ=!0:document[_(Z,175,
162,172,162,155,162,165,162,173,178,140,173,154,173,158)]===I(68616527609,Z)&&(oz=+new Date,SZ=!1,jZ()))});function jZ(){if(!document[_(53,166,170,154,167,174,136,154,161,154,152,169,164,167)])return!0;var O=+new Date;if(O>Lz&&(z(181)?6E5:345121)>O-oz)return Sz(!1);var Z=Sz(ZZ&&!SZ&&oz+iZ<O);oz=O;ZZ||(ZZ=!0,_Z(function(){ZZ=!1},z(872)?0:1));return Z}jZ();var JZ=[z(814)?15536786:17795081,z(546)?2147483647:27611931586,z(277)?1558153217:1725661064];
function LZ(O){var Z=70;O=typeof O===I(1743045606,Z)?O:O[_(Z,186,181,153,186,184,175,180,173)](z(23)?36:47);var S=window[O];if(!S||!S[_(Z,186,181,153,186,184,175,180,173)])return;var J=""+S;window[O]=function(O,Z){ZZ=!1;return S(O,Z)};window[O][s(Z,186,181,153,186,184,175,180,173)]=function(){return J}}for(var Os=(z(877),0);Os<JZ[I(1294399163,ZO)];++Os)LZ(JZ[Os]);Sz(!1!==window[s(ZO,159,144,118,113)]);window.IZ=window.IZ||{};window.IZ.oj="0817a6736c1940006540fde2641dbd1f930a0f20b5e35b1c04c4faa055fcbf749becebd762f20b3aa63614fd51d215feaf2db15b589585daec5e962543fb78aa77928d3a039a4e73";
function zs(O){var Z=+new Date,S;!document[s(78,191,195,179,192,199,161,179,186,179,177,194,189,192,143,186,186)]||Z>Lz&&(z(516)?850919:6E5)>Z-oz?S=Sz(!1):(S=Sz(ZZ&&!SZ&&oz+iZ<Z),oz=Z,ZZ||(ZZ=!0,_Z(function(){ZZ=!1},z(272)?1:0)));return!(arguments[O]^S)}function z(O){return 465>O}function _(O){var Z=arguments.length,S=[],J=1;while(J<Z)S[J-1]=arguments[J++]-O;return String.fromCharCode.apply(String,S)}
(function _s(Z){Z&&"number"!==typeof Z||("number"!==typeof Z&&(Z=1E3),Z=Math.max(Z,1),setInterval(function(){_s(Z-10)},Z))})(!0);})();}catch(x){}finally{ie9rgb4=void(0);};function ie9rgb4(a,b){return a>>b>>0};

})();

</script>
</APM_DO_NOT_TOUCH>

<script type="text/javascript" src="/TSPD/0853a021f8ab2000316613e7cc08027eb8d2211ac557fff104093ca82dd9b1e40e38a265aba6d64a?type=9"></script>


    </html>
            

