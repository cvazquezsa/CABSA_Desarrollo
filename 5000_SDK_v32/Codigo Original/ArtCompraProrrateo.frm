[Forma]
Clave=ArtCompraProrrateo
Nombre=Tabla Prorrateo - Compras
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=207
PosicionInicialArriba=176
PosicionInicialAlturaCliente=381
PosicionInicialAncho=609
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Totalizadores=S
PosicionSeccion1=90
Comentarios=Lista(Info.Articulo, Info.Descripcion)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtCompraProrrateo
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=ArtCompraProrrateo.Articulo=<T>{Info.Articulo}<T>

[Lista.ArtCompraProrrateo.Porcentaje]
Carpeta=Lista
Clave=ArtCompraProrrateo.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

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
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(ArtCompraProrrateo:ArtCompraProrrateo.Grupo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Lista.Columnas]
Grupo=256
Porcentaje=64
Cantidad=109
Sucursales=55
CantidadTotal=82

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=% Total<BR>Sucursales<BR>Cantidad Total
Totalizadores2=Suma(ArtCompraProrrateo:ArtCompraProrrateo.Porcentaje)<BR>Suma(ArtCompraProrrateo:Sucursales)<BR>Suma(ArtCompraProrrateo:CantidadTotal)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Totalizadores3=<BR><BR>(Cantidades)

[(Carpeta Totalizadores).% Total]
Carpeta=(Carpeta Totalizadores)
Clave=% Total
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[Lista.ArtCompraProrrateo.Grupo]
Carpeta=Lista
Clave=ArtCompraProrrateo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtCompraProrrateo.Cantidad]
Carpeta=Lista
Clave=ArtCompraProrrateo.Cantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Lista.Sucursales]
Carpeta=Lista
Clave=Sucursales
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris
Efectos=[Negritas]

[Lista.CantidadTotal]
Carpeta=Lista
Clave=CantidadTotal
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris
Efectos=[Negritas]

[(Carpeta Totalizadores).Sucursales]
Carpeta=(Carpeta Totalizadores)
Clave=Sucursales
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Cantidad Total]
Carpeta=(Carpeta Totalizadores)
Clave=Cantidad Total
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[Lista.ListaEnCaptura]
(Inicio)=ArtCompraProrrateo.Grupo
ArtCompraProrrateo.Grupo=Sucursales
Sucursales=ArtCompraProrrateo.Cantidad
ArtCompraProrrateo.Cantidad=CantidadTotal
CantidadTotal=ArtCompraProrrateo.Porcentaje
ArtCompraProrrateo.Porcentaje=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Sucursales
Sucursales=Cantidad Total
Cantidad Total=% Total
% Total=(Fin)
