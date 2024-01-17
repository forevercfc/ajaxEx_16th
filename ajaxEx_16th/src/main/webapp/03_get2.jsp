<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
</head>
<body>
    <h1>위클리 박스오피스</h1>
    <table border=1>
        <thead>
            <tr>
                <td>박스오피스 순위</td>
                <td></td>
                <td>영화명</td>
                <td>개봉일</td>
                <td>금일까지 누적 관객수</td>
                <td>금일까지 누적 수익</td>
            </tr>
        </thead>
        <tbody class="table_body"></tbody>
    </table>

    <script>
        $(function () {
            var today = getDate();
            console.log("getDate()의 리턴값: " + today);

            var urlValue = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=" + today;
            console.log("urlValue: " + urlValue);

            getJSON();

            function getJSON() {
                $.ajax({
                    type: "get",
                    url: urlValue,
                    dataType: "json",
                    success: function(data) {
                        console.log("통신 성공");
                        var list = data.boxOfficeResult.dailyBoxOfficeList;
                        for (var i = 0; i < list.length; i++) {
                            var str = '<tr>' +
                                '<td>' + list[i].rank + '</td>' +
                                '<td><img src="./resources/images/'+list[i].rank+'.jpg"/></td>' +
                                '<td>' + list[i].movieNm + '</td>' +
                                '<td>' + list[i].openDt + '</td>' +
                                '<td>' + list[i].audiAcc + '</td>' +
                                '<td>' + list[i].salesAcc + '</td>' +
                                '</tr>';
                            $('.table_body').append(str);
                        }
                    },
                    error: function() {
                        console.log("통신 에러");
                    }
                });
            }

            function getDate() {
                var date = new Date();
                var yyyy = date.getFullYear();
                var mm = date.getMonth() + 1;
                var dd = date.getDate() - 1;

                if (mm < 10) mm = "0" + mm;
                if (dd < 10) dd = "0" + dd;
                return yyyy + mm + dd;
            }
        });
    </script>
</body>
</html>
