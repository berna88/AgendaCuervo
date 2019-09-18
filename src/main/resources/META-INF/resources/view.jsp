<%@ include file="/init.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %><%@
taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %><%@
taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %><%@
taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
  
  

<portlet:defineObjects/>

  

<liferay-portlet:resourceURL var="resourceUrl1">
	<liferay-portlet:param  name="pdf" value="descargar"/>
</liferay-portlet:resourceURL>
<style>
 
</style>



<div class="Directorio">
<div class="tituloSeccion-contenedor d-flex align-items-center justify-content-center">
			<img src='<%=request.getContextPath()+"/img/directorio.jpg" %>' alt="" class="img-fliud">
			<div class="mascara-tituloSeccion"></div>
			<h1 class="tituloSeccion position-absolute">
				Directorio
			</h1>
		</div>
<div id="org-content" class="container ">
<h2 class="titulo-contenido text-center mt-25 mb-50">Elije el Centro de trabajo de tu preferencia</h2>
<div id="owl-demo" class="owl-carousel owl-theme row">
          <c:forEach var="org" items="${Logos}">
          <div class="col-xs-12 item" id="${org.getOrganizationId()}" onclick="init(this.id)" >
	<img  src="/image/layout_set_logo?img_id=<c:out value="${org.getLogoId()}" />"> </img>
	<h2 class="txt-org"><c:out value="${org.getName()}" /></h2>
		</div>
</c:forEach>

</div>
</div>

</div>
<div id="tablero">
<div class="modal modal-org" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Modal Heading</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <div class="container">
<div class="row">
<div id="modal-card" class="card">
</div>
</div>
</div>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>


<div class="container-fluid">
<div class="input-group mb-3">
  <div class="input-group-prepend">
    <span class="input-group-text" id="basic-addon1">search</span>
  </div>
  <input type="text" id="myInput" class="form-control" placeholder="Username" aria-label="Username" aria-describedby="basic-addon1">
</div>


<div id="id-card-deck" width="100%" class="card-deck">
<div class="row row-eq-height">
</div>
</div>

</div>
<button id="id-button" type="button" class="btn btn-outline-primary">Get more users</button>
<div class="loader"></div>

 <input type="text" id="test3" >

</div>



<script type="text/javascript">



var server = Liferay.ThemeDisplay.getPortalURL();
var array=[];
function getCard(card){
for (var i in card)
                {   
                    var url = server +card[i].image;
                    $('#id-card-deck').append(
                    '<div class="col-sm-2">'+
                    '<div class="card text-center" height:350px; max-height:350px; >'+
                    '<img src="'+url+'" class="card-img-top" alt="...">'+
                    ' <div class="card-body">'+
      '<h5 class="card-title">'+card[i].Firstname+'</h5>'+
      ' <p class="card-text">'+card[i].Email+
      '</p><p class="card-text"><small class="text-muted">'+card[i].status+'</small></p>'+
    '</div>'+
    '<button type="button" data-toggle="modal" data-target="#myModal" class="btn btn-outline-primary" onclick="renderCard('+card[i].userId+')">show info</button>'+
    '</div>'+
     '</div>');
                   
                }
 $('.loader').hide();
    
}

function renderCard(card){
$('#modal-card').html('');
       $.get(server +"/o/api-agenda/getUserById?userId="+card, function(res){
        //Loop through each row and output the data
      $('#modal-card').append('<div class="col">'+
                    '<div class="card text-center mb-3">'+
                    '<img src="'+res.image+'" class="card-img-top" alt="...">'+
                    ' <div class="card-body">'+
      '<h5 class="card-title">'+res.Firstname+'</h5>'+
      ' <p class="card-text">'+res.Email+
      '</p><p class="card-text"><small class="text-muted">'+res.status+'</small></p>'+
    '</div>'+
    '</div>'+
    '</div>');
        });
}

function getPage(page_num,def_per_page,organizationId)
{
    $('.loader').show();
    //Clear the existing data view
    $('.card-deck').html('');
    var url=server +'/o/api-agenda/getAllUsers?start='+page_num+'&finish='+def_per_page+"&organizationId="+organizationId;
    //Get subset of data
    $.get(url, function(res){
        //Loop through each row and output the data
       for (var i in res)
        {   
        array.push(res[i]);
        }
         getCard(array);
        });
      $('.card-deck').empty();
    
}


function getResults(result,organizationId)
{
    $('.loader').show();
    array=[];
    //Clear the existing data view
    $('.card-deck').html('');
    var url=server+'/o/api-agenda/getUsersByScreenNameOrEmail?item='+result+"&organizationId="+organizationId;
    //Get subset of data
    $.get(url, function(res){
        //Loop through each row and output the data
       for (var i in res)
        {   
        array.push(res[i]);
        }
         getCard(array);
        });
      $('.card-deck').empty();
    
}



$(document).ready(function(){
 var count=10;
$("#myInput").on("input", function(){
        // Print entered value in a div box
        var text=$("#myInput").val();
        getResults(text,window.global);
        console.log(text);
    });
    
 $("#id-button").click(function(){
        getPage(count,count + 10,window.global);
        count = count + 10;
    });
   
    
});
</script>
<script>
  var global;
  $("#myModal").modal();
  $("#myModal").modal("hide");
  $('.loader').hide();
  
  function init(organizationId){
	$('.card-deck').html('');
	array=[];
	$("#test3").val(organizationId);
	window.global=organizationId;
	getPage(0,10,organizationId);
	document.getElementById('tablero').style.display = 'block';
	document.getElementById('org-content').style.display = 'none';
	}
    
		

	$(document).ready(function() {
		 
		  $("#owl-demo").owlCarousel({
		    navigation : true
		  });
		 
		});
	</script>
	<style>
	.txt-org{
	position: absolute;
    display: inline-block;
   top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
	}
	
	#owl-demo .item{
  background: transparent;
  padding: 30px 0px;
  margin: 10px;
  color: #FFF;
  border-radius:50%;
  -webkit-border-radius: 3px;
  -moz-border-radius: 3px;
  border-radius: 3px;
  text-align: center;
}
#owl-demo .item {
    
    height: 100%;
    width: 60%;
    margin: auto;
    }
    .owl-carousel .owl-item img {
    display: block;
    width: 100%;
    height: 100%;
    border-radius: 50%;
}
.titulo-contenido {
    color: #FFF;
    font-family: "Source Sans Variable";
    font-size: 1.8em;
    }

.loader {
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid blue;
  border-bottom: 16px solid blue;
  width: 120px;
  height: 120px;
  -webkit-animation: spin 2s linear infinite;
  animation: spin 2s linear infinite;
}

/*-------------------modal user -------------*/
#myModal.modal-org {
    width: 100%;
    margin-left: 0;
    margin-right: 10%;
    background: 0;
    background: #000000b0;
}
/*-------------------------------------------*/

@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}    
    /*

    
    .container-org {
    width: 70%;
    background: red;
    margin: auto;
}
        width: 300px;
    height: 300px;
    border-radius: 50%;
    background: green;
}
    
    */
    
    #tablero{
    display:none;
    }
    
   #id-card-deck > .card .text-center {
        background: black;
    }
    .card-deck .card {
  
    background: black;
}
</style>
	