[Forma]
Clave=CteRelacion
Nombre=Relación entre Clientes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAltura=445
PosicionInicialAncho=679
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=290
PosicionInicialArriba=158
Comentarios=Info.Cliente
PosicionInicialAlturaCliente=418

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=0
ExpresionesAlMostrar=Asigna(Info.ClienteA, Info.Cliente)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CteRelacion
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral={Si(ConDatos(Info.Cliente), <T>CteRelacion.Cliente=<T>+Comillas(Info.Cliente)+<T> OR CteRelacion.Relacion=<T>+Comillas(Info.Cliente),<T>1=1<T>)}
[Lista.CteRelacion.Relacion]
Carpeta=Lista
Clave=CteRelacion.Relacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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
Relacion=97
Nombre=204
Cliente=109
Nombre_1=237

[Lista.CteRelacion.Cliente]
Carpeta=Lista
Clave=CteRelacion.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.CteDestino.Nombre]
Carpeta=Lista
Clave=CteDestino.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.Todos]
Nombre=Todos
Boton=55
NombreEnBoton=S
NombreDesplegar=&Todas las Relaciones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Antes=S


AntesExpresiones=Asigna(Info.Cliente, Nulo)
Visible=S
[Lista.ListaEnCaptura]
(Inicio)=CteRelacion.Cliente
CteRelacion.Cliente=Cte.Nombre
Cte.Nombre=CteRelacion.Relacion
CteRelacion.Relacion=CteDestino.Nombre
CteDestino.Nombre=(Fin)






[Acciones.CteRelaciones]
Nombre=CteRelaciones
Boton=38
NombreEnBoton=S
NombreDesplegar=&Relaciones Cliente
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S





Antes=S
AntesExpresiones=Asigna(Info.Cliente, Info.ClienteA)










[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Todos
Todos=CteRelaciones
CteRelaciones=(Fin)
