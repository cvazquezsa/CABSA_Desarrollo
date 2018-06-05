[Forma]
Clave=ArtQuiebre
Nombre=e(<T>Quiebre<T>)+<T> - <T>+Info.ArtFam
Icono=4
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=233
PosicionInicialArriba=253
PosicionInicialAlturaCliente=483
PosicionInicialAncho=813
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Asigna(Temp.Reg, SQL(<T>SELECT UltimoQuiebre, QuiebreFechaD, QuiebreFechaA FROM ArtFam WHERE Familia=:tFam<T>, Info.ArtFam))<BR>Lista(e(<T>Ultima Actualización<T>)+<T>: <T>+FechaEnTexto(Temp.Reg[1], <T>dd/mmm/aaaa hh:nn am/pm<T>), e(<T>Del<T>)+<T>: <T>+FechaEnTexto(Temp.Reg[2], <T>dd/mmm/aaaa<T>), e(<T>Al<T>)+<T>: <T>+FechaEnTexto(Temp.Reg[3], <T>dd/mmm/aaaa<T>), e(<T>Base<T>)+<T>: <T>+Info.Base)
Totalizadores=S
PosicionSeccion1=93

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtQuiebre
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGrupo1=(Validaciones Memoria)
FiltroValida1=ArtFam
FiltroAplicaEn1=Art.Familia
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroAplicaEn=Art.Familia
FiltroAutoCampo=Art.Familia
FiltroAutoValidar=Art.Familia
FiltroGeneral=ArtQuiebre.Familia=<T>{Info.ArtFam}<T>

[Lista.ArtQuiebre.Articulo]
Carpeta=Lista
Clave=ArtQuiebre.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.Ventas]
Carpeta=Lista
Clave=ArtQuiebre.Ventas
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.Devoluciones]
Carpeta=Lista
Clave=ArtQuiebre.Devoluciones
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.Faltantes]
Carpeta=Lista
Clave=ArtQuiebre.Faltantes
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.Scanner]
Carpeta=Lista
Clave=ArtQuiebre.Scanner
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=105
Descripcion1=170
Ventas=64
Devoluciones=68
Faltantes=57
DemandaAjustada=95
Scanner=55
ScannerAjustado=89
DemandaNeta=75
Estatus=94
VentaAjustada=78

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=92
NombreEnBoton=S
NombreDesplegar=&Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
ConCondicion=S
Visible=S
EjecucionCondicion=Forma(<T>ArtQuiebreActualizar<T>)

[Lista.Art.Estatus]
Carpeta=Lista
Clave=Art.Estatus
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.VentaAjustada]
Carpeta=Lista
Clave=ArtQuiebre.VentaAjustada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ArtQuiebre.DemandaNeta]
Carpeta=Lista
Clave=ArtQuiebre.DemandaNeta
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Totalizadores1=Total
Totalizadores2=Suma(ArtQuiebre:ArtQuiebre.VentaAjustada)
Totalizadores3=(Cantidades)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Total
CarpetaVisible=S

[(Carpeta Totalizadores).Total]
Carpeta=(Carpeta Totalizadores)
Clave=Total
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtQuiebrePreliminar
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
AntesExpresiones=Asigna(Rep.SumaCantidades, Suma(ArtQuiebre:ArtQuiebre.VentaAjustada))

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreDesplegar=&Guardar Cambios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Actualizar
Actualizar=Guardar
Guardar=Preliminar
Preliminar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ArtQuiebre.Articulo
ArtQuiebre.Articulo=Art.Descripcion1
Art.Descripcion1=Art.Estatus
Art.Estatus=ArtQuiebre.Ventas
ArtQuiebre.Ventas=ArtQuiebre.Devoluciones
ArtQuiebre.Devoluciones=ArtQuiebre.Faltantes
ArtQuiebre.Faltantes=ArtQuiebre.DemandaNeta
ArtQuiebre.DemandaNeta=ArtQuiebre.Scanner
ArtQuiebre.Scanner=ArtQuiebre.VentaAjustada
ArtQuiebre.VentaAjustada=(Fin)
