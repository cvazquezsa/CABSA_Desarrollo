[Forma]
Clave=ArtArancel
Nombre=Aranceles
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=280
PosicionInicialArriba=326
PosicionInicialAltura=300
PosicionInicialAncho=719
PosicionInicialAlturaCliente=344

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtArancel
Fuente={MS Sans Serif, 8, Negro, []}
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

[Lista.ArtArancel.Arancel]
Carpeta=Lista
Clave=ArtArancel.Arancel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtArancel.Porcentaje]
Carpeta=Lista
Clave=ArtArancel.Porcentaje
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
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtArancel:ArtArancel.Arancel)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.Columnas]
Arancel=237
Porcentaje=48
Unidad=85
Cuota=122
Porcentaje2=46
UnidadVenta=74
UnidadCompra=73

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

[Lista.ArtArancel.Unidad]
Carpeta=Lista
Clave=ArtArancel.Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtArancel.Cuota]
Carpeta=Lista
Clave=ArtArancel.Cuota
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtArancel.Porcentaje2]
Carpeta=Lista
Clave=ArtArancel.Porcentaje2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.TratadoComercial]
Nombre=TratadoComercial
Boton=47
NombreEnBoton=S
NombreDesplegar=&Tratados Comerciales
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtArancelTratadoComercial
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ArtArancel:ArtArancel.Arancel)
AntesExpresiones=Asigna(Info.Arancel, ArtArancel:ArtArancel.Arancel)

[Acciones.lProgramaSectorial]
Nombre=lProgramaSectorial
Boton=47
NombreEnBoton=S
NombreDesplegar=&Programas Sectoriales
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtArancelProgramaSectorial
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(ArtArancel:ArtArancel.Arancel)
Antes=S
AntesExpresiones=Asigna(Info.Arancel, ArtArancel:ArtArancel.Arancel)

[Lista.ArtArancel.UnidadVenta]
Carpeta=Lista
Clave=ArtArancel.UnidadVenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtArancel.UnidadCompra]
Carpeta=Lista
Clave=ArtArancel.UnidadCompra
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=TratadoComercial
TratadoComercial=lProgramaSectorial
lProgramaSectorial=Excel
Excel=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtArancel.Arancel
ArtArancel.Arancel=ArtArancel.Unidad
ArtArancel.Unidad=ArtArancel.UnidadVenta
ArtArancel.UnidadVenta=ArtArancel.UnidadCompra
ArtArancel.UnidadCompra=ArtArancel.Cuota
ArtArancel.Cuota=ArtArancel.Porcentaje
ArtArancel.Porcentaje=ArtArancel.Porcentaje2
ArtArancel.Porcentaje2=(Fin)
