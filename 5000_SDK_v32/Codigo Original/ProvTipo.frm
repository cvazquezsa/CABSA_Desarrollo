[Forma]
Clave=ProvTipo
Nombre=Tipos Proveedores
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=523
PosicionInicialArriba=286
PosicionInicialAlturaCliente=425
PosicionInicialAncho=234
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
Vista=ProvTipo
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
ListaOrden=ProvTipo.Orden<TAB>(Acendente)

[Lista.ProvTipo.Tipo]
Carpeta=Lista
Clave=ProvTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProvTipo.Orden]
Carpeta=Lista
Clave=ProvTipo.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tipo=165
Orden=38

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
EjecucionCondicion=ConDatos(ProvTipo:ProvTipo.Tipo)
Antes=S
AntesExpresiones=Asigna(Info.Tipo, <T>Proveedor<T>)<BR>Asigna(Info.SubTipo, ProvTipo:ProvTipo.Tipo)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CampoExtra
CampoExtra=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProvTipo.Tipo
ProvTipo.Tipo=ProvTipo.Orden
ProvTipo.Orden=(Fin)
