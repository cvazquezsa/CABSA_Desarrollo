[Forma]
Clave=ExplorarSaldoUOpcion
Nombre=<T>Explotando Información - Existencias<T>
Icono=47
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=73
PosicionInicialArriba=51
PosicionInicialAlturaCliente=595
PosicionInicialAncho=855
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Cubo.VistaNombre(<T>Lista<T>)

EsConsultaExclusiva=S
[Lista]
Estilo=Cubo
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SaldoUOpcion
Fuente={Tahoma, 8, Negro, []}
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=SaldoUOpcion.Grupo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S

FiltroGrupo2=SaldoUOpcion.Cuenta
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

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Cubo.Personalizar(<T>Lista<T>)

[Acciones.Expresion]
Nombre=Expresion
Boton=0
NombreDesplegar=Expresion
EnMenu=S
TipoAccion=Expresion
Expresion=Informacion(<T>Hola<T>)
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Cubo.GuardarComoExcel(<T>Lista<T>)

[Acciones.SaveAs]
Nombre=SaveAs
Boton=3
NombreDesplegar=&Guardar como...
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=Cubo.GuardarComoOtraVista( <T>Lista<T>, Info.VistaNombre )
EjecucionCondicion=Forma(<T>EspecificarVistaNombre<T>)

[Acciones.AbrirComo]
Nombre=AbrirComo
Boton=2
NombreDesplegar=Abrir Vista
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=Cubo.SeleccionarVista( <T>Lista<T> )

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreDesplegar=Eliminar
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=Cubo.EliminarVistaActual( <T>Lista<T> )
Activo=S
Visible=S



















































































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=AbrirComo
AbrirComo=SaveAs
SaveAs=Eliminar
Eliminar=Personalizar
Personalizar=Excel
Excel=(Fin)
