<?php

ini_set('display_erros', true);
error_reporting(E_ALL);
require_once('../vendor/autoload.php');

use Dotenv\Dotenv;

$dotenv = Dotenv::createUnsafeMutable('/opt/lampp/htdocs/mscode/desafio/');

$dotenv->load();



class MySql
{

    private $db;
    private $ipHost;
    private $nomeBanco;
    private $user;
    private $password;
    private $tabela;

    public function __construct($tabela)
    {

        //Configurando o acesso ao banco de dados
        $this->ipHost = getenv(('DB_HOST'));
        $this->nomeBanco = getenv(('DB_NAME'));
        $this->user = getenv(('DB_USER'));
        $this->password = getenv(('DB_PASS'));
        $this->tabela = $tabela;


        var_dump($this->ipHost);
        die('aqui');
        //Conectando ao banco de dados
        $this->db = new PDO('mysql:host=' . $this->ipHost . ';dbname=' . $this->nomeBanco, $this->user, $this->password, array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"));
        $this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }




    public function inserir(array $dados)
    {
        $campos = implode(", ", array_keys($dados));
        $valores = "'" . implode("' , '", array_values($dados)) . "'";

        $sql = " INSERT INTO `{$this->tabela}` ({$campos}) VALUES ({$valores}) ";
        $resultSet = $this->db->prepare($sql);

        $retorno = false;
        try {
            $resultSet->execute();
            $retorno = true;
        } catch (PDOException $ex) {
            echo 'Erro inesperado: ' . $ex->getMessage();
            exit;
        }
        return $retorno;
    }

    public function buscar($where = null, $limit = null, $offset = null, $orderby = null)
    {
        $where = ($where != null ? "WHERE {$where}" : "");
        $limit = ($limit != null ? "LIMIT {$limit}" : "");
        $offset = ($offset != null ? "OFFSET {$offset}" : "");
        $orderby = ($orderby != null ? "ORDER BY {$orderby}" : "");

        $sql = " SELECT * FROM `{$this->tabela}` {$where} {$orderby} {$limit} {$offset}";
        $resultSet = $this->db->prepare($sql);

        $retorno = false;
        try {
            $resultSet->execute();
            $resultSet->setFetchMode(PDO::FETCH_ASSOC);
            $retorno = $resultSet->fetchAll();
        } catch (PDOException $ex) {
            echo 'Erro inesperado: ' . $ex->getMessage();
            exit;
        }
        return $retorno;
    }

    public function atualizar(array $dados, $where)
    {
        foreach ($dados as $indice => $val) {
            $campos[] = "{$indice} = '{$val}'";
        }
        $campos_query = implode(", ", $campos);
        $sql = " UPDATE `{$this->tabela}` SET {$campos_query} WHERE {$where}";
        $resultSet = $this->db->prepare($sql);

        //echo $sql;
        //exit;

        //Tratamento com PDO e chamada de Excessão - Usado tambem contra SQL Injection
        $retorno = false;
        try {
            $resultSet->execute();
            $retorno = true;
        } catch (PDOException $ex) {
            echo 'Erro inesperado: ' . $ex->getMessage();
            exit;
        }
        return $retorno;
    }

    public function deletar($where)
    {
        $sql = " DELETE FROM {$this->tabela} WHERE {$where}";
        $resultSet = $this->db->prepare($sql);

        //Tratamento com PDO e chamada de Excessão - Usado tambem contra SQL Injection
        $retorno = false;
        try {
            $resultSet->execute();
            $retorno = true;
        } catch (PDOException $ex) {
            echo 'Erro inesperado: ' . $ex->getMessage();
            exit;
        }
        return $retorno;
    }

    public function runQuery($query)
    {

        $resultSet = $this->db->prepare($query);

        $retorno = false;
        try {
            $resultSet->execute();
            $resultSet->setFetchMode(PDO::FETCH_ASSOC);
            $retorno = $resultSet->fetchAll();
        } catch (PDOException $ex) {
            echo 'Erro inesperado: ' . $ex->getMessage();
            exit;
        }
        return $retorno;
    }
}
