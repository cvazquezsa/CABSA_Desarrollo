[Forma]
Clave=Comprador
Nombre=Compradores
Icono=0
Modulos=(Lista)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaCarpetas=Comprador
PosicionInicialIzquierda=346
PosicionInicialArriba=218
PosicionInicialAltura=324
PosicionInicialAncho=333
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
CarpetaPrincipal=Comprador
ListaAcciones=(Lista)
BarraHerramientas=S
VentanaBloquearAjuste=N
PosicionInicialAlturaCliente=297

[Lista.Comprador.Comprador]
Carpeta=Lista
Clave=Comprador.Comprador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5

[Lista.Columnas]
Comprador=81

[Lista]
Estilo=Hoja
Pestana=
PestanaOtroNombre=Si
PestanaNombre=Compradores
Clave=Lista
PermiteEditar=Si
GuardarPorRegistro=
AlineacionAutomatica=Si
AcomodarTexto=Si
MostrarConteoRegistros=Si
Zona=A1
Vista=Comprador
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=
HojaMostrarColumnas=
HojaMostrarRenglones=Si
HojaColoresPorEstatus=Si
HojaMantenerSeleccion=Si
HojaPermiteInsertar=Si
HojaPermiteEliminar=Si
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Comprador.Comprador
CarpetaVisible=Si
HojaAjustarColumnas=Si
CondicionEditar=FormaNormal
CondicionEdicion=
OtroOrden=Si
ListaOrden=Comprador.Comprador<TAB>(Acendente)
HojaConfirmarEliminar=Si

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
Icono=0
NombreDesplegar=&Guardar Cambios
EnBarraAcciones=Si
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Expresion=
SQL=
ListaParametros=Si
Visible=Si
VisibleCondicion=
Activo=Si
ActivoCondicion=
EjecucionCondicion=
EjecucionMensaje=
AntesExpresiones=

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=Si
EnBarraAcciones=Si
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=Si
Activo=Si
NombreEnBoton=Si
EnBarraHerramientas=Si

[Comprador]
Estilo=Hoja
Clave=Comprador
PermiteEditar=Si
AlineacionAutomatica=Si
AcomodarTexto=Si
MostrarConteoRegistros=Si
Zona=A1
Vista=Comprador
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=
HojaMostrarColumnas=
HojaMostrarRenglones=Si
HojaColoresPorEstatus=Si
HojaPermiteInsertar=Si
HojaPermiteEliminar=Si
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Comprador.Comprador
CarpetaVisible=Si
HojaConfirmarEliminar=Si

[Comprador.Comprador.Comprador]
Carpeta=Comprador
Clave=Comprador.Comprador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Comprador.Columnas]
Comprador=304

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Forma.Modulos]
(Inicio)=CXP
CXP=COMP
COMP=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
