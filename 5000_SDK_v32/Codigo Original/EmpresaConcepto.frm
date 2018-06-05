[Forma]
Clave=EmpresaConcepto
Nombre=<T>Conceptos de Movimientos - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Empresa
PosicionInicialIzquierda=213
PosicionInicialArriba=230
PosicionInicialAltura=300
PosicionInicialAncho=597
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaConcepto
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
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=EmpresaConcepto.Empresa=<T>{Info.Empresa}<T>

[Lista.EmpresaConcepto.Modulo]
Carpeta=Lista
Clave=EmpresaConcepto.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaConcepto.Mov]
Carpeta=Lista
Clave=EmpresaConcepto.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaConcepto.Concepto]
Carpeta=Lista
Clave=EmpresaConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Modulo=64
Mov=117
Concepto=199
Requerido=57
UtilizarEste=127

[Lista.EmpresaConcepto.Requerido]
Carpeta=Lista
Clave=EmpresaConcepto.Requerido
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaConcepto.UtilizarEste]
Carpeta=Lista
Clave=EmpresaConcepto.UtilizarEste
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.ConceptosValidos]
Nombre=ConceptosValidos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Conceptos del Movimiento
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmpresaConceptoValidar
Activo=S
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
EjecucionCondicion=ConDatos(EmpresaConcepto:EmpresaConcepto.Modulo) y ConDatos(EmpresaConcepto:EmpresaConcepto.Mov)
AntesExpresiones=Asigna(Info.Modulo, EmpresaConcepto:EmpresaConcepto.Modulo)<BR>Asigna(Info.Mov, EmpresaConcepto:EmpresaConcepto.Mov)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=ConceptosValidos
ConceptosValidos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=EmpresaConcepto.Modulo
EmpresaConcepto.Modulo=EmpresaConcepto.Mov
EmpresaConcepto.Mov=EmpresaConcepto.Concepto
EmpresaConcepto.Concepto=EmpresaConcepto.Requerido
EmpresaConcepto.Requerido=EmpresaConcepto.UtilizarEste
EmpresaConcepto.UtilizarEste=(Fin)
