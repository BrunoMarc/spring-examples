<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:include page="template-header.jsp" >
    <jsp:param name="title" value="Entradas :: Agenda Pessoal" />
    <jsp:param name="active" value="entradas" />
</jsp:include>

	<!-- CONTEÚDO -->
    <div class="container-fluid">
    
      <div class="row-fluid">
      	<div class="col-lg-3 col-md-12">
      	
	      	<!-- Filtro de pesquisa -->
	        <form id="form-filtro" class="well" role="form" method="get" action="<c:url value="/entradas" />">
	          <div class="row">
		        <div class="col-lg-12 col-md-3 col-sm-12">
		        	<div class="form-group">
				      <label class="control-label col-sm-2 col-md-2 col-lg-12">De</label>
				      <div class="col-sm-4 col-md-10 col-lg-12">
				        <input type="date" class="form-control input-sm" id="de" name="de" 
				        	value="<fmt:formatDate pattern="yyyy-MM-dd" value="${filtro.de}" />">
 				      </div>
 				     </div>
				    </div>
		        <div class="col-lg-12 col-md-3 col-sm-12">
		        	<div class="form-group">
				      <label class="control-label col-sm-2 col-md-2 col-lg-12">Até</label>
				      <div class="col-sm-4 col-md-10 col-lg-12">
				      	<input type="date" class="form-control input-sm" id="ate" name="ate" 
				      		value="<fmt:formatDate pattern="yyyy-MM-dd" value="${filtro.ate}" />">
				      </div>
				    </div>
				</div>
		        <div class="col-lg-12 col-md-4 col-sm-12">
		        	<div class="form-group">
			 	        <label class="col-sm-2 col-md-3 col-lg-12">Descrição</label>
			 	        <div class="col-sm-10 col-md-9 col-lg-12">
					      <input type="text" class="form-control input-sm" id=descricao 
					      		placeholder="Pesquisar descrição" name="descricao" value="${filtro.descricao}">
					    </div>
				    </div>
				</div>
		        <div class="col-lg-12 col-md-2 col-sm-12">
		        	<div class="form-group">
						<div class="btn-group btn-group-sm col-lg-12">
						  <button type="submit" class="btn btn-primary" id="botao-filtrar"><span class="glyphicon glyphicon-search"></span></button>
						  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
						    <span class="caret"></span>
						    <span class="sr-only">Opções</span>
						  </button>
						  <ul class="dropdown-menu" role="menu">
						    <li><a class="text-center" href="#" id="botao-limpar">Limpar filtros</a></li>
						  </ul>
						</div>
					</div>
				</div>
		      </div>
		      
		      <!-- hidden fields to maintain ordering -->
	          <input type="hidden" name="coluna" value="${ordem.coluna}"/>
	          <input type="hidden" name="ordem" value="${ordem.ordem}"/>
			</form>
		</div>

		<c:url value="/entradas" var="urlOrdenacaoHorario">
			<c:param name="de" value="${filtro.de}" />
			<c:param name="ate" value="${filtro.ate}" />
			<c:param name="descricao" value="${filtro.descricao}" />
			<c:param name="coluna" value="horario" />
			<c:param name="ordem" value="${ordem.colunaDefault == 'descricao' ||  ordem.ordemDefault == 'desc' ? 'asc' : 'desc'}" />
		</c:url>
		<c:url value="/entradas" var="urlOrdenacaoDescricao">
			<c:param name="de" value="${filtro.de}" />
			<c:param name="ate" value="${filtro.ate}" />
			<c:param name="descricao" value="${filtro.descricao}" />
			<c:param name="coluna" value="descricao" />
			<c:param name="ordem" value="${ordem.colunaDefault == 'horario' || ordem.ordemDefault == 'desc' ? 'asc' : 'desc'}" />
		</c:url>

		<div class="col-lg-9 col-md-12">	
	      	<h2>Entradas da agenda 
	      	  <a href="<c:url value="/entrada?new"/>" class="btn btn-success pull-right">Nova Entrada <span class="glyphicon glyphicon-plus"></span></a></h2>
	      	
	        <!-- <table class="table table-striped table-hover table-bordered table-condensed"> -->
	        <table class="table table-hover table-bordered ">
	          <thead>
	            <tr>
	              <th class="text-center coluna-codigo">#</th> <!-- Código -->
	              <th class="text-left coluna-data"><a href="${urlOrdenacaoHorario}">Data 
	                <c:if test="${ordem.colunaDefault == 'horario'}">
					  <span class="glyphicon glyphicon-sort-by-attributes${ordem.ordemDefault == 'desc' ? '-alt' : ''}"></span>
					</c:if></a>
				  </th> 
	              <th class="text-left coluna-descricao"><a href="${urlOrdenacaoDescricao}">Descrição
	                <c:if test="${ordem.colunaDefault == 'descricao'}">
					  <span class="glyphicon glyphicon-sort-by-attributes${ordem.ordemDefault == 'desc' ? '-alt' : ''}"></span> 
	                </c:if></a>
	              </th>
			   	  <th class="text-right coluna-acao"></th>
	            </tr>
	          </thead>
	          <tbody>
	          	<c:forEach items="${entradas}" var="entrada">
	            <tr class="${entrada.prioridade.code == 'I' ? 'danger' : '' }${entrada.prioridade.code == 'A' ? 'warning' : '' }${entrada.prioridade.code == 'P' ? 'success' : '' }">
	              <td class="text-center">${entrada.id}</td>
	              <td><fmt:formatDate pattern="dd/MM/yyyy hh:mm" value="${entrada.horario}" /></td>
	              <td>${entrada.descricao}</td>
	              <td class="text-right">
			        <a href="<c:url value="/entrada/${entrada.id}"/>" title="Editar Entrada" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-pencil"></span></a>
	   				<a href="<c:url value="/entrada/remover/${entrada.id}"/>" data-id="${entrada.id}" data-horario="<fmt:formatDate pattern="dd/MM/yyyy' às 'hh:mm" value="${entrada.horario}" />"
	   					title="Excluir Entrada" class="btn btn-danger btn-xs link-excluir"><span class="glyphicon glyphicon-remove"></span></a>
	              </td>
	            </tr>
	            </c:forEach>
	          </tbody>
	        </table>
	     </div>    
	  </div>

    </div> <!-- /container -->
    
    <!-- modal -->
    <div id="modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="ConfirmationModal" aria-hidden="true">
	  <div class="modal-dialog modal-sm">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span></button>
	        <h4 class="modal-title">Confirmar de Remoção</h4>
	      </div>
	      <div class="modal-body">
	      	<p>Quer mesmo excluir a entrada <strong><span class="id-entrada"></span></strong> em <strong><span class="horario-entrada"></span></strong>?</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
	        <a href="#" class="btn btn-danger botao-remover">Remover</a>
	      </div>
	    </div>
	  </div>
	</div>
    
<jsp:include page="template-footer.jsp" />