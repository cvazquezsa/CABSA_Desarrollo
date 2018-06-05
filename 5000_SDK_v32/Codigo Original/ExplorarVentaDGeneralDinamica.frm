[Forma]
Clave=ExplorarVentaDGeneralDinamica
Nombre=<T>Explotando Información - Ventas General (Detalle)<T>
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
Vista=VentaExplorarDDinamica
Fuente={Tahoma, 8, Negro, []}
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=(Validaciones Memoria)
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=25
FiltroRespetar=S
FiltroTipo=Múltiple (por Grupos)
FiltroTodo=S

FiltroGrupo2=(Validaciones Memoria)
FiltroValida1=ArtCat
FiltroValida2=ArtGrupo
FiltroGrupo3=(Validaciones Memoria)
FiltroValida3=ArtFam
FiltroGrupo4=(Validaciones Memoria)
FiltroValida4=ArtLinea
FiltroGrupo5=(Validaciones Memoria)
FiltroValida5=Fabricante
FiltroGrupo6=(Validaciones Memoria)
FiltroValida6=Agente
FiltroAplicaEn1=Art.Categoria
FiltroAplicaEn2=Art.Grupo
FiltroAplicaEn3=Art.Familia
FiltroAplicaEn4=Art.Linea
FiltroAplicaEn5=Art.Fabricante
FiltroAplicaEn6=Venta.Agente
FiltroTodoFinal=S
FiltroArbol=Articulos
FiltroListas=S
FiltroListasRama=INV
FiltroListasAplicaEn=VentaD.Articulo
FiltroArbolAplica=Art.Rama
FiltroGeneral=Venta.Empresa=<T>{Empresa}<T>
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
