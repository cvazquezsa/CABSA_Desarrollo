[Forma]
Clave=PersonalTipo
Nombre=Tipos Personal
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=491
PosicionInicialArriba=286
PosicionInicialAlturaCliente=425
PosicionInicialAncho=233
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PersonalTipo
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
OtroOrden=S
ListaOrden=PersonalTipo.Orden<TAB>(Acendente)

[Lista.PersonalTipo.Tipo]
Carpeta=Lista
Clave=PersonalTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PersonalTipo.Orden]
Carpeta=Lista
Clave=PersonalTipo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tipo=165
Orden=38
EsSocio=64

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

[Acciones.CampoExtra]
Nombre=CampoExtra
Boton=104
NombreEnBoton=S
NombreDesplegar=&Campos Extras
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CtoTipoCampoExtra
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(PersonalTipo:PersonalTipo.Tipo)
Antes=S
AntesExpresiones=Asigna(Info.Tipo, <T>Personal<T>)<BR>Asigna(Info.SubTipo, PersonalTipo:PersonalTipo.Tipo)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CampoExtra
CampoExtra=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PersonalTipo.Tipo
PersonalTipo.Tipo=PersonalTipo.Orden
PersonalTipo.Orden=(Fin)
