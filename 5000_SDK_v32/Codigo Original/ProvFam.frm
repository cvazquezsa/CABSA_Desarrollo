[Forma]
Clave=ProvFam
Nombre=Familias de Proveedores
Icono=0
Modulos=CXP
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
Vista=ProvFam
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ProvFam.Familia
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

[Lista.ProvFam.Familia]
Carpeta=Lista
Clave=ProvFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=45

[Detalle.ProvFam.Familia]
Carpeta=Detalle
Clave=ProvFam.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
Efectos=[Negritas]

[Detalle.ProvFam.Icono]
Carpeta=Detalle
Clave=ProvFam.Icono
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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ProvFam:ProvFam.Familia)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Detalle.Columnas]
Familia=64
Descripcion=304
Icono=64

[Detalle.ProvFam.FamiliaMaestra]
Carpeta=Detalle
Clave=ProvFam.FamiliaMaestra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[ProvFamD.ProvFamD.TipoPropiedad]
Carpeta=ProvFamD
Clave=ProvFamD.TipoPropiedad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[ProvFamD.Columnas]
TipoPropiedad=194

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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
