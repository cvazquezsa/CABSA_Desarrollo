[Forma]
Clave=CtaFam
Nombre=Familias de Cuentas
Icono=0
Modulos=(Lista)
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
PosicionInicialIzquierda=381
PosicionInicialArriba=229
PosicionInicialAltura=309
PosicionInicialAncho=261
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
BarraHerramientas=S
PosicionSeccion1=43
PosicionColumna1=46

[Lista]
Estilo=Hoja
Pestana=
PestanaOtroNombre=
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=Si
AcomodarTexto=Si
MostrarConteoRegistros=Si
Zona=A1
Vista=CtaFam
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CtaFam.Familia
CarpetaVisible=Si
PermiteEditar=Si
HojaTitulos=Si
HojaMostrarColumnas=
HojaColoresPorEstatus=Si
HojaMantenerSeleccion=Si
HojaMostrarRenglones=Si
HojaPermiteInsertar=Si
HojaPermiteEliminar=Si
HojaConfirmarEliminar=Si

[Lista.CtaFam.Familia]
Carpeta=Lista
Clave=CtaFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=45

[Detalle.CtaFam.Familia]
Carpeta=Detalle
Clave=CtaFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
Efectos=[Negritas]

[Detalle.CtaFam.Icono]
Carpeta=Detalle
Clave=CtaFam.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
Familia=233
Descripcion=310

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
NombreEnBoton=S
EnBarraHerramientas=S
Visible=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(CtaFam:CtaFam.Familia)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Detalle.Columnas]
Familia=64
Descripcion=304
Icono=64

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
(Inicio)=CXC
CXC=VTAS
VTAS=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
