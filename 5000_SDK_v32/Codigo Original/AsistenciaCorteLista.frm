
[Forma]
Clave=AsistenciaCorteLista
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Asistencia Corte Lista

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=446
PosicionInicialArriba=264
PosicionInicialAlturaCliente=216
PosicionInicialAncho=468
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Seleccionar
[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AuxAsistenciaAsiste
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S


IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPaginaEsp=200
IconosSubTitulo=<T>Movimiento<T>
Filtros=S
IconosNombre=AuxAsistenciaAsiste:Asiste.Mov
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=Asiste.Estatus = <T>CONCLUIDO<T>
FiltroRespetar=S
FiltroTipo=General
[Lista.Asiste.MovID]
Carpeta=Lista
Clave=Asiste.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Lista.Asiste.FechaEmision]
Carpeta=Lista
Clave=Asiste.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Asiste.FechaD]
Carpeta=Lista
Clave=Asiste.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Asiste.FechaA]
Carpeta=Lista
Clave=Asiste.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Columnas]
0=-2
1=88
2=-2
3=113
4=88
5=116
6=-2




MovID=64
Empresa=45
FechaEmision=94
Estatus=94
FechaD=64
FechaA=94

Mov=64
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S

Activo=S
Visible=S
NombreEnBoton=S



TipoAccion=Ventana
ClaveAccion=Aceptar
Antes=S

AntesExpresiones=Asigna(Info.ID,AuxAsistenciaAsiste:Asiste.ID)<BR>Asigna(Info.Sucursal,AuxAsistenciaAsiste:Asiste.Sucursal)
[Acciones.Seleccionar.ListaAccionesMultiples]
(Inicio)=Expression
Expression=Seleccionar
Seleccionar=(Fin)







[Lista.ListaEnCaptura]
(Inicio)=Asiste.MovID
Asiste.MovID=Asiste.FechaEmision
Asiste.FechaEmision=Asiste.FechaD
Asiste.FechaD=Asiste.FechaA
Asiste.FechaA=(Fin)
