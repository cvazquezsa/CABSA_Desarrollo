[Forma]
Clave=SIC
Nombre=Sectores Industriales (SIC)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=599
PosicionInicialArriba=381
PosicionInicialAlturaCliente=402
PosicionInicialAncho=828
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SIC
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
ValidarCampos=S
ListaCamposAValidar=Agente.Nombre

[Lista.SIC.SIC]
Carpeta=Lista
Clave=SIC.SIC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SIC.Nombre]
Carpeta=Lista
Clave=SIC.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SIC.Industria]
Carpeta=Lista
Clave=SIC.Industria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SIC.Giro]
Carpeta=Lista
Clave=SIC.Giro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
SIC=107
Nombre=246
Industria=155
Giro=172
AgentePorOmision=106

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Industria]
Nombre=Industria
Boton=91
NombreEnBoton=S
NombreDesplegar=&Industrias
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Industria
Activo=S
Visible=S

[Lista.SIC.AgentePorOmision]
Carpeta=Lista
Clave=SIC.AgentePorOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Industria
Industria=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SIC.SIC
SIC.SIC=SIC.Nombre
SIC.Nombre=SIC.Industria
SIC.Industria=SIC.Giro
SIC.Giro=SIC.AgentePorOmision
SIC.AgentePorOmision=(Fin)
