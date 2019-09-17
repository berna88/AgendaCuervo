<%@ include file="/init.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %><%@
taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %><%@
taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %><%@
taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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
<div class="container">
<h2 class="titulo-contenido text-center mt-25 mb-50">Elije el Centro de trabajo de tu preferencia</h2>
<div id="owl-demo" class="owl-carousel owl-theme row">
          <c:forEach var="org" items="${Logos}">
          <div class="col-xs-12 item" id="${org.getOrganizationId()}" onclick="getIdOrganization(this.id)" >
	<img  src="/image/layout_set_logo?img_id=<c:out value="${org.getLogoId()}" />"> </img>
	<h2 class="txt-org"><c:out value="${org.getName()}" /></h2>
		</div>
</c:forEach>

</div>
</div>
<!--  
<div class="carousel">
<c:forEach var="org" items="${Logos}">
	<img id="${org.getOrganizationId()}" onclick="getIdOrganization(this.id)" src="/image/layout_set_logo?img_id=<c:out value="${org.getLogoId()}" />"><p><c:out value="${org.getName()}" /></p> </img>
</c:forEach>
</div>
-->
</div>








<script type="text/javascript">
		function getIdOrganization(idOrganization){
			console.log(idOrganization);
			AUI().use('aui-io-request', function(A){
	            A.io.request('${resourceUrl1}', {
	                   method: 'post',
	                   data: {
	                	   <portlet:namespace />param2: idOrganization,
	                   },
	                   on: {
	                       	success: function() {
	                        alert(this.get('responseData'));
	                        alert(idOrganization);
	                       }
	                  }
	            });
	     
	        });
		}
	</script>
	<script>
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
</style>
	