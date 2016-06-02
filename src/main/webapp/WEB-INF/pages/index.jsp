<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    /*
     * ELB checks your application's health by periodically
     * sending an HTTP HEAD request to a resource in your application. By
     * default, this is the root or default resource in your application,
     * but can be configured for each environment.
     *
     * Here, we report success as long as the app server is up, but skip
     * generating the whole page since this is a HEAD request only. You
     * can employ more sophisticated health checks in your application.
     */
    if (request.getMethod().equals("HEAD")) return;
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-type" content="text/html; charset=utf-8">
    <title>Ternos sob medida para cães! (Uma app de exemplo para o CodeDeploy)</title>
    <meta name="viewport" content="initial-scale=1.0">
    <link rel='stylesheet' href='webjars/bootstrap/3.2.0/css/bootstrap.min.css'>
    <link rel='stylesheet' href='webjars/bootstrap/3.2.0/css/bootstrap-theme.min.css'>
    <link rel='stylesheet' href='css/theme.css'>
</head>
<body role="document">
  <nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#">Ternos sob medida para seu cãozinho</a>
      </div>
      <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
          <li class="active"><a href="#">Home</a></li>
        </ul>
      </div>
    </div>
  </nav>
  <% if (!((String) request.getAttribute("deploymentGroupName")).contains("Prod")) { %>
    <div class="alert alert-info" role="alert">
      <p><strong>AWS CodeDeploy Application:</strong> ${applicationName}</p>
      <p><strong>AWS CodeDeploy Deployment Group:</strong> ${deploymentGroupName}</p>
      <strong>Instâncias associadas a esta tag/frota:</strong>
      <ul>
        <% for (final String instance : (List<String>) request.getAttribute("instanceIds")) { %>
          <% if (((Map<String, String>) request.getAttribute("instanceStates")).containsKey(instance)) { %>
            <li> <%= instance %> - Instance Health: <%= ((Map<String, String>) request.getAttribute("instanceStates")).get(instance) %></li>
          <% } else { %>
            <li> <%= instance %> - Instance Health: Unknown</li>
          <% } %>
        <% } %>
      </ul>
    </div>
  <% } %>
  <div class="container theme-showcase" role="main" style="background-color: #B9DEF0;">
  <!--div class="container theme-showcase" role="main"-->
    <% if (((String) request.getAttribute("deploymentGroupName")).contains("Prod")) { %>
      <div class="alert alert-dismissible alert-warning">
        <button type="button" class="close" data-dismiss="alert">×</button>
        <h1>Estamos Funcionando!</h1>
        <p>Para celebrar a abertura de nossa loja, todos os ternos estao com <b>25% de desconto</b> e com <b>frete grátis!</b></p>
        <!-- div class="row">
          <h2><center>Dê estilo ao seu cachorrinho!</center></h2>
          <div class="col-sm-4">
            <center><img src="images/sales-lobsterdog.png" style="width:287px;height:360px;"></center>
          </div>
          <div class="col-sm-4" style="font-size: 300px">
            <center>&#8594;</center>
          </div>
          <div class="col-sm-4">
            <center><img src="images/classy-dog1.png" style="width:268px;height:360px;"><center>
          </div>
        </div -->
      </div>
    <% } %>
    <div class="jumbotron">
      <h1>Ternos sob medida para cães</h1>
      <p><i>Por quê seu cachorrinho não pode ser classudo?</i></p>
    </div>
    <div class="page-header">
      <h1>Nossos Produtos</h1>
    </div>

    <div class="row">
      <div class="col-sm-4">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Aproveite uma noite na cidade</h3>
          </div>
          <div class="panel-body">
            Você tem um encontro especial? Faça de seu cãozinho parte do encontro!
            <img src="images/casual-dog2.png" style="width:236px;height:295px;">
          </div>
        </div>
      </div>
      <div class="col-sm-4">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Ideal para fotos de familia</h3>
          </div>
          <div class="panel-body">
            Com ternos tão classudos, todos vão querer uma foto com seu cãozinho!
            <img src="images/fancy-dog3.png" style="width:295px;height:433px;">
          </div>
        </div>
      </div>
      <div class="col-sm-4">
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Customizações grátis</h3>
          </div>
          <div class="panel-body">
            Todas as compras vem com customizações grátis para garantir que seu cão esteja confortável e bem vestido.
            <img src="images/alterations-dog4.png" style="width:287px;height:300px;">
          </div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript" src="webjars/jquery/2.1.1/jquery.min.js"></script>
  <script type="text/javascript" src="webjars/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>
