[Forma]
Clave=MovAutorizar
Nombre=<T>Autorizar: <T> & Afectar.Mov & <T> <T> & Afectar.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=518
PosicionInicialArriba=394
PosicionInicialAlturaCliente=93
PosicionInicialAncho=243
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
VentanaEscCerrar=S
VentanaExclusiva=S
AccionesDivision=S
AccionesCentro=S
BarraHerramientas=S
ExpresionesAlMostrar=Si <BR>  Usuario.Autorizar<BR>Entonces<BR>  Asigna(Info.Usuario, Usuario)<BR>  Asigna(Info.Contrasena, Usuario.Contrasena)<BR>Sino<BR>  Asigna(Info.Usuario, Nulo)<BR>  Asigna(Info.Contrasena, Nulo)<BR>Fin

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.Usuario]
Carpeta=(Variables)
Clave=Info.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Contrasena]
Carpeta=(Variables)
Clave=Info.Contrasena
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=si(vacio(info.Contrasena),Asigna(Info.Contrasena, MD5(Info.Contrasena, <T>p<T>)))<BR>Si<BR>  Sucursal=SQL(<T>SELECT Sucursal FROM UsuarioSucursal WHERE Usuario=:tUsuario AND Empresa=:tEmp<T>, Info.Usuario, Empresa)<BR>Entonces<BR>  Asigna(Temp.Reg, SQL(<T>SELECT u.Usuario, u.Contrasena, u.Autorizar, u.AutorizarVenta, u.AutorizarCxp, u.AutorizarGasto, u.AutorizarDinero, u.AutorizarCompra, u.AutorizarGestion FROM Usuario u, UsuarioD d WHERE u.Usuario=:tUsuario AND u.Usuario=d.Usuario AND d.Empresa=:tEmp<T>, Info.Usuario, Empresa))<BR>  Si<BR>    Temp.Reg[1]=Info.Usuario<BR>  Entonces<BR>    Si<BR>      (Igual(Temp.Reg[2], MD5(Info.Contrasena, <T>p<T>))) o (Igual(Temp.Reg[2],Info.Contrasena))<BR>    Entonces<BR>      Si<BR>        Temp.Reg[3] y ((Afectar.Modulo=<T>VTAS<T> y Temp.Reg[4]) o (Afectar.Modulo=<T>CXP<T> y Temp.Reg[5]) o (Afectar.Modulo=<T>GAS<T> y Temp.Reg[6]) o (Afectar.Modulo=<T>DIN<T> y Temp.Reg[7]) o (Afectar.Modulo=<T>COMS<T> y Temp.Reg[8]) o (Afectar.Modulo=<T>GES<T> y Temp.Reg[9]))<BR>      Entonces<BR>        Autorizar(Afectar.Modulo, Afectar.ID, Afectar.Mov, Afectar.MovID, <T>Todo<T>, <T><T>, Afectar.FormaCaptura, Info.Usuario)<BR>          Si SQL(<T>spMovReporteIntelisis :tEmpresa, :tModulo, :tMov, :nID, :nAfectar<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID, 1) Entonces<BR>            Asigna(Info.Reporte, SQL(<T>spMovFormatoIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID))<BR>            Asigna(Info.RutaArchivo, SQL(<T>spMovRutaIntelisis :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID))<BR>            ReportePDF(Info.Reporte,Afectar.ID,Info.RutaArchivo)<BR>            EjecutarSQL(<T>spMovEnviarIntelisis :tEmpresa,:tModulo,:tMov,:nID<T>,Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID)<BR>          Fin<BR>      Si<BR>        Empresa.CFD y SQL(<T>spVerMovTipoCFD :tEmpresa, :tModulo, :tMov, :nID<T>, Empresa, Afectar.Modulo, Afectar.Mov, Afectar.ID)<BR>      Entonces<BR>        Si(no CFD.Generar(Afectar.Modulo, Afectar.ID),  Forma.ActualizarForma AbortarOperacion)<BR>        Asigna(Afectar.EnviarCFD, SQL(<T>SELECT EnviarAlAfectar FROM EmpresaCFD WHERE Empresa=:tEmpresa<T>, Empresa))<BR>      Fin<BR>      Si(Afectar.EnviarCFD, CFD.Enviar(Afectar.Modulo, Afectar.ID))<BR>      Sino<BR>        Error(<T>El Usuario Indicado No Puede Autorizar<T>)<BR>      Fin<BR>    Sino<BR>      Error(<T>Contraseña Incorrecta<T>)<BR>    Fin<BR>  Sino<BR>    Error(<T>Usuario Incorrecto<T>)<BR>  Fin<BR>Sino<BR>  Error(<T>El Usuario Indicado No Esta Accesando Esta Sucursal<T>)<BR>Fin
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Autorizar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=<T>&Cancelar<T>
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[(Variables).ListaEnCaptura]
(Inicio)=Info.Usuario
Info.Usuario=Info.Contrasena
Info.Contrasena=(Fin)













[Lista.Columnas]
0=99
1=375












[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
