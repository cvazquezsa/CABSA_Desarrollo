
[Forma]
Clave=RepAntSaldosPedidos
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=482
PosicionInicialArriba=325
PosicionInicialAlturaCliente=122
PosicionInicialAncho=315
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Nombre=Antigüedad de Saldos Pedidos
[Ficha]
Estilo=Ficha
Clave=Ficha
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

[Ficha.RepParam.InfoClienteD]
Carpeta=Ficha
Clave=RepParam.InfoClienteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RepParam.InfoClienteA]
Carpeta=Ficha
Clave=RepParam.InfoClienteA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RepParam.InfoDesglosar]
Carpeta=Ficha
Clave=RepParam.InfoDesglosar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

EspacioPrevio=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S






[Lista.Columnas]
Cliente=117
Nombre=293
RFC=107














































[Ficha.ListaEnCaptura]
(Inicio)=RepParam.InfoClienteD
RepParam.InfoClienteD=RepParam.InfoClienteA
RepParam.InfoClienteA=RepParam.InfoDesglosar
RepParam.InfoDesglosar=(Fin)




[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=RepAntSaldosPedidos
Activo=S
Visible=S


[Acciones.Imprimir]
Nombre=Imprimir
Boton=46
NombreEnBoton=S
NombreDesplegar=Imprimir
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Impresora
ClaveAccion=RepAntSaldosPedidos
Activo=S
Visible=S



























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
