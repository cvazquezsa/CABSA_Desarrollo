
[Forma]
Clave=EcuadorReporte103
Icono=0
Modulos=(Todos)

ListaCarpetas=RepParam
CarpetaPrincipal=RepParam
PosicionInicialAlturaCliente=165
PosicionInicialAncho=318
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=481
PosicionInicialArriba=304
Nombre=Ecuador Reporte 103
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[RepParam]
Estilo=Ficha
Clave=RepParam
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

[RepParam.RepParam.InfoFechaD]
Carpeta=RepParam
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[RepParam.RepParam.InfoFechaA]
Carpeta=RepParam
Clave=RepParam.InfoFechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[RepParam.RepParam.InfoMoneda]
Carpeta=RepParam
Clave=RepParam.InfoMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[RepParam.RepParam.InfoSucursal]
Carpeta=RepParam
Clave=RepParam.InfoSucursal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20






[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=Preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=EcuadorReporte103
Activo=S
Visible=S



GuardarAntes=S
EspacioPrevio=S



[Lista.Columnas]
0=91
1=267





Empresa=71
Nombre=371
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=Imprimir
EnBarraHerramientas=S
TipoAccion=Reportes Impresora
ClaveAccion=EcuadorReporte103
Activo=S
Visible=S













































[RepParam.RepParam.InfoEmpresa]
Carpeta=RepParam
Clave=RepParam.InfoEmpresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco




[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoMoneda
RepParam.InfoMoneda=RepParam.InfoSucursal
RepParam.InfoSucursal=RepParam.InfoEmpresa
RepParam.InfoEmpresa=(Fin)






[(Carpeta Abrir).Columnas]
0=138
1=332
2=-2









[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=Imprimir
Imprimir=(Fin)
