[Forma]
Clave=ProdAvanzarLista
Nombre=Avanzar Lista de Lotes
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=473
PosicionInicialArriba=216
PosicionInicialAlturaCliente=557
PosicionInicialAncho=334
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ListaProdSerieLote
Fuente={Fixedsys, 9, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=ListaProdSerieLote.SerieLote
CarpetaVisible=S
ConFuenteEspecial=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ListaProdSerieLote.Estacion={EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General

[Lista.ListaProdSerieLote.SerieLote]
Carpeta=Lista
Clave=ListaProdSerieLote.SerieLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
SerieLote=305

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

[Acciones.Avanzar]
Nombre=Avanzar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Avanzar Lista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=ProcesarSQL(<T>spAvanzarListaProdSerieLote :tEmpresa, :tUsuario, :nEstacion<T>, Empresa, Usuario, EstacionTrabajo)<BR>Forma.ActualizarVista

[Acciones.Importar]
Nombre=Importar
Boton=2
NombreEnBoton=S
NombreDesplegar=&Importar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
GuardarAntes=S
Expresion=Si(RegistrarLista(LeerLista(<T><T>, <T>*.txt<T>, <T>TXT<T>, <T>Datos<T>, <T>Datos<T>), Verdadero), EjecutarSQL(<T>spListaProdSerieLote :nEstacion<T>, EstacionTrabajo)  Forma.ActualizarVista ))

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Importar
Importar=Avanzar
Avanzar=(Fin)
