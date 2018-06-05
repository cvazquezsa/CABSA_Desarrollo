[Forma]
Clave=PedimentoClave
Nombre=Claves Pedimentos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=363
PosicionInicialArriba=310
PosicionInicialAlturaCliente=361
PosicionInicialAncho=610

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PedimentoClave
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
HojaMantenerSeleccion=S

[Lista.PedimentoClave.PedimentoClave]
Carpeta=Lista
Clave=PedimentoClave.PedimentoClave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PedimentoClave.Descripcion]
Carpeta=Lista
Clave=PedimentoClave.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
PedimentoClave=85
Descripcion=385
Temporalidad=109

[Acciones.PedimentoClaveRegimen]
Nombre=PedimentoClaveRegimen
Boton=47
NombreEnBoton=S
NombreDesplegar=&Regimenes
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=PedimentoClaveRegimen
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
ConCondicion=S
EjecucionCondicion=ConDatos(PedimentoClave:PedimentoClave.PedimentoClave)
AntesExpresiones=Asigna(Info.Clave, PedimentoClave:PedimentoClave.PedimentoClave)

[Lista.PedimentoClave.Temporalidad]
Carpeta=Lista
Clave=PedimentoClave.Temporalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=PedimentoClaveRegimen
PedimentoClaveRegimen=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PedimentoClave.PedimentoClave
PedimentoClave.PedimentoClave=PedimentoClave.Descripcion
PedimentoClave.Descripcion=PedimentoClave.Temporalidad
PedimentoClave.Temporalidad=(Fin)
