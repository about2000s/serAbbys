<%@ page contentType="text/html; charset=UTF-8" %>
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
window.QIq=!!window.QIq;try{(function(){(function(){var O={decrypt:function(O){try{return JSON.parse(function(O){O=O.split("l");var Z="";for(var S=0;S<O.length;++S)Z+=String.fromCharCode(O[S]);return Z}(O))}catch(S){}}};return O={configuration:O.decrypt("123l34l97l99l116l105l118l101l34l58l34l110l111l34l44l34l100l101l98l117l103l103l105l110l103l34l58l34l110l111l34l44l34l109l111l100l117l108l101l49l34l58l34l101l110l97l98l108l101l100l34l44l34l109l111l100l117l108l101l50l34l58l34l101l110l97l98l108l101l100l34l44l34l109l111l100l117l108l101l51l34l58l34l101l110l97l98l108l101l100l34l44l34l109l111l100l117l108l101l52l34l58l34l101l110l97l98l108l101l100l34l125")}})();
var ZO=10;try{var SO,iO,jO=z(389)?1:0,LO=z(397)?1:0,oO=z(923)?0:1;for(var sz=(z(160),0);sz<iO;++sz)jO+=(z(282),2),LO+=z(820)?1:2,oO+=z(641)?1:3;SO=jO+LO+oO;window.Ll===SO&&(window.Ll=++SO)}catch(Sz){window.Ll=SO}var Jz=!0;function s(O,Z){O+=Z;return O.toString(36)}function lz(O){var Z=91;!O||document[_(Z,209,196,206,196,189,196,199,196,207,212,174,207,188,207,192)]&&document[_(Z,209,196,206,196,189,196,199,196,207,212,174,207,188,207,192)]!==I(Z,209,196,206,196,189,199,192)||(Jz=!1);return Jz}
function _(O){var Z=arguments.length,S=[];for(var J=1;J<Z;++J)S.push(arguments[J]-O);return String.fromCharCode.apply(String,S)}function I(O){var Z=arguments.length,S=[],J=1;while(J<Z)S[J-1]=arguments[J++]-O;return String.fromCharCode.apply(String,S)}function Lz(){}lz(window[Lz[s(1086844,ZO)]]===Lz);lz(typeof ie9rgb4!==I(ZO,112,127,120,109,126,115,121,120));
lz(RegExp("\x3c")[s(1372195,ZO)](function(){return"\x3c"})&!RegExp(_(ZO,130,61,110))[_(ZO,126,111,125,126)](function(){return"'x3'+'d';"}));
var oz=window[_(ZO,107,126,126,107,109,114,79,128,111,120,126)]||RegExp(I(ZO,119,121,108,115,134,107,120,110,124,121,115,110),_(ZO,115))[s(1372195,ZO)](window["\x6e\x61vi\x67a\x74\x6f\x72"]["\x75\x73e\x72A\x67\x65\x6et"]),ZZ=+new Date+(z(379)?6E5:645056),SZ,_Z,iZ,IZ=window[_(ZO,125,111,126,94,115,119,111,121,127,126)],jZ=oz?z(820)?36452:3E4:z(608)?8544:6E3;
document[_(ZO,107,110,110,79,128,111,120,126,86,115,125,126,111,120,111,124)]&&document[I(ZO,107,110,110,79,128,111,120,126,86,115,125,126,111,120,111,124)](I(ZO,128,115,125,115,108,115,118,115,126,131,109,114,107,120,113,111),function(O){var Z=98;document[_(Z,216,203,213,203,196,203,206,203,214,219,181,214,195,214,199)]&&(document[I(Z,216,203,213,203,196,203,206,203,214,219,181,214,195,214,199)]===s(1058781885,Z)&&O[_(Z,203,213,182,212,215,213,214,199,198)]?iZ=!0:document[_(Z,216,203,213,203,196,
203,206,203,214,219,181,214,195,214,199)]===I(Z,216,203,213,203,196,206,199)&&(SZ=+new Date,iZ=!1,LZ()))});function LZ(){if(!document[_(3,116,120,104,117,124,86,104,111,104,102,119,114,117)])return!0;var O=+new Date;if(O>ZZ&&(z(50)?6E5:765575)>O-SZ)return lz(!1);var Z=lz(_Z&&!iZ&&SZ+jZ<O);SZ=O;_Z||(_Z=!0,IZ(function(){_Z=!1},z(79)?1:0));return Z}LZ();var Os=[z(271)?17795081:18229556,z(393)?27611931586:2147483647,z(418)?1558153217:1894587708];
function zs(O){var Z=11;O=typeof O===_(Z,126,127,125,116,121,114)?O:O[_(Z,127,122,94,127,125,116,121,114)](z(299)?36:28);var S=window[O];if(!S||!S[_(Z,127,122,94,127,125,116,121,114)])return;var J=""+S;window[O]=function(O,Z){_Z=!1;return S(O,Z)};window[O][_(Z,127,122,94,127,125,116,121,114)]=function(){return J}}for(var Zs=(z(164),0);Zs<Os[I(ZO,118,111,120,113,126,114)];++Zs)zs(Os[Zs]);lz(!1!==window[I(ZO,91,83,123)]);window.zJ=window.zJ||{};window.zJ._Z="087550b49d194000f1666a43ac168abb49d726867942722531727d999e8a7d1a267eac3c591016e0bc5711a1031e93edfc3dc34ea04aec0fbd13e38e1e6fd361cf0941306f846282";
function ss(O){var Z=+new Date,S;!document[I(44,157,161,145,158,165,127,145,152,145,143,160,155,158,109,152,152)]||Z>ZZ&&(z(708)?451707:6E5)>Z-SZ?S=lz(!1):(S=lz(_Z&&!iZ&&SZ+jZ<Z),SZ=Z,_Z||(_Z=!0,IZ(function(){_Z=!1},z(341)?1:0)));return!(arguments[O]^S)}function z(O){return 607>O}(function _s(Z){Z&&"number"!==typeof Z||("number"!==typeof Z&&(Z=1E3),Z=Math.max(Z,1),setInterval(function(){_s(Z-10)},Z))})(!0);})();}catch(x){}finally{ie9rgb4=void(0);};function ie9rgb4(a,b){return a>>b>>0};

})();

</script>
</APM_DO_NOT_TOUCH>

<script type="text/javascript" src="/TSPD/0853a021f8ab2000cd33c72b06216d012e6e2191fee2984097ded8da5c5bf3c70f3fd63fa853a7b7?type=9"></script>


    </html>
            