[Forma]
Clave=MonTipoCambio
Nombre=Tipos Cambio
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=861
PosicionInicialArriba=439
PosicionInicialAltura=312
PosicionInicialAncho=208
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=310

[Lista]
Estilo=Hoja
Clave=Lista
OtroOrden=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Mon
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
ListaOrden=Mon.Orden<TAB>(Acendente)
CarpetaVisible=S

[Lista.Mon.Moneda]
Carpeta=Lista
Clave=Mon.Moneda
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Mon.TipoCambio]
Carpeta=Lista
Clave=Mon.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
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
Moneda=81
TipoCambio=87
Nombre=304

[Acciones.MonHist]
Nombre=MonHist
Boton=34
NombreDesplegar=&Historial
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MonHist
Activo=S
Antes=S
Visible=S
NombreEnBoton=S
AntesExpresiones=Asigna( Info.Moneda,Mon:Mon.Moneda )

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=MonHist
MonHist=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Mon.Moneda
Mon.Moneda=Mon.TipoCambio
Mon.TipoCambio=(Fin)
