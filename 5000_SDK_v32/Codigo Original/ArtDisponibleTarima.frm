
[Forma]
Clave=ArtDisponibleTarima
Nombre=Disponible Nivel Tarima
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=384
PosicionInicialArriba=100
PosicionInicialAlturaCliente=488
PosicionInicialAncho=598
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
Comentarios=Lista(Info.Articulo, Info.Almacen)

PosicionSec1=212
PosicionCol2=248
PosicionSec2=212
PosicionCol3=248
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ArtDisponibleTarima
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Tarima<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Tarimas
OtroOrden=S
ListaOrden=ArtDisponibleTarima.Tarima<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

IconosNombre=ArtDisponibleTarima:Tarima.Tarima
FiltroGeneral=ArtDisponibleTarima.Empresa=<T>{Empresa}<T><BR>AND ArtDisponibleTarima.Articulo=<T>{Info.Articulo}<T><BR>AND ArtDisponibleTarima.Almacen=<T>{Info.Almacen}<T><BR>{Si(ConDatos(Info.Almacen), <T> AND ArtDisponibleTarima.Almacen= <T>+Comillas(Info.Almacen), <T><T>)}<BR>AND ArtDisponibleTarima.Disponible>0
[Lista.ArtDisponibleTarima.Disponible]
Carpeta=Lista
Clave=ArtDisponibleTarima.Disponible
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=147
1=80

2=-2
3=-2
4=-2
5=-2
6=80
7=-2
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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a E&xcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S




[Lista.AlmPos.Descripcion]
Carpeta=Lista
Clave=AlmPos.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco







[Lista.Tarima.Posicion]
Carpeta=Lista
Clave=Tarima.Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



[Lista.AlmPos.Tipo]
Carpeta=Lista
Clave=AlmPos.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco













[Lista.Tarima.SubCuenta]
Carpeta=Lista
Clave=Tarima.SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco









[DisponibleTransito.TarimaTransito]
Carpeta=DisponibleTransito
Clave=TarimaTransito
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[DisponibleTransito.ArtDisponibleTarima.Almacen]
Carpeta=DisponibleTransito
Clave=ArtDisponibleTarima.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[DisponibleTransito.Columnas]
TarimaTransito=124
Almacen=64











[SubDisponibleTransito]
Estilo=Iconos
Pestana=S
Clave=SubDisponibleTransito
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Vista=ArtSubDisponibleTarimaTransito
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Blanco

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

IconosSubTitulo=<T>Tarima<T>


PestanaOtroNombre=S
PestanaNombre=Tránsito Disponible
ListaEnCaptura=(Lista)
IconosNombre=ArtSubDisponibleTarimaTransito:TarimaTransito
FiltroGeneral=ArtSubDisponibleTarima.Empresa=<T>{Empresa}<T> AND ArtSubDisponibleTarima.Articulo=<T>{Info.Articulo}<T> AND ArtSubDisponibleTarima.Almacen=<T>{Info.Almacen}<T> AND<BR>ArtSubDisponibleTarima.Disponible>0
CondicionVisible=SQL(<T>SELECT COUNT(*) FROM ArtSubDisponibleTarima WHERE Empresa=:tEmpresa AND ArtSubDisponibleTarima.Articulo=:tArticulo AND ArtSubDisponibleTarima.Almacen=:tAlmacen AND ArtSubDisponibleTarima.Disponible>0<T>, Empresa, Info.Articulo, Info.Almacen)>0
[SubDisponibleTransito.Columnas]
0=140
1=85




2=236



[DisponibleTransito.ListaEnCaptura]
(Inicio)=TarimaTransito
TarimaTransito=ArtDisponibleTarima.Almacen
ArtDisponibleTarima.Almacen=(Fin)





[SubDisponibleTransito.Disponible]
Carpeta=SubDisponibleTransito
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco










[SubDisponibleTransito.SubCuenta]
Carpeta=SubDisponibleTransito
Clave=SubCuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco































[SubDisponibleTransito.ListaEnCaptura]
(Inicio)=SubCuenta
SubCuenta=Disponible
Disponible=(Fin)












[Lista.ArtDisponibleTarima.Apartado]
Carpeta=Lista
Clave=ArtDisponibleTarima.Apartado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco








[Lista.Dispo]
Carpeta=Lista
Clave=Dispo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

































[Lista.ListaEnCaptura]
(Inicio)=Tarima.SubCuenta
Tarima.SubCuenta=ArtDisponibleTarima.Disponible
ArtDisponibleTarima.Disponible=ArtDisponibleTarima.Apartado
ArtDisponibleTarima.Apartado=Dispo
Dispo=Tarima.Posicion
Tarima.Posicion=AlmPos.Descripcion
AlmPos.Descripcion=AlmPos.Tipo
AlmPos.Tipo=(Fin)









[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=SubDisponibleTransito
SubDisponibleTransito=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)
