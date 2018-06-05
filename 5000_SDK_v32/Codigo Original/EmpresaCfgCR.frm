[Forma]
Clave=EmpresaCfgCR
Nombre=Plantilla - Cajas Registradoras
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Empresa
PosicionInicialIzquierda=482
PosicionInicialArriba=312
PosicionInicialAlturaCliente=373
PosicionInicialAncho=315
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaCfgCR
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
ValidarCampos=S
ListaCamposAValidar=Art.Descripcion1
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=EmpresaCfgCR.Empresa=<T>{Empresa}<T>

[Lista.EmpresaCfgCR.Articulo]
Carpeta=Lista
Clave=EmpresaCfgCR.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.EmpresaCfgCR.FormaPago]
Carpeta=Lista
Clave=EmpresaCfgCR.FormaPago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
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

[Lista.Columnas]
Articulo=124
Descripcion1=184
FormaPago=161
Agente=129
Nombre=304

[Lista.ListaEnCaptura]
(Inicio)=EmpresaCfgCR.Articulo
EmpresaCfgCR.Articulo=EmpresaCfgCR.FormaPago
EmpresaCfgCR.FormaPago=(Fin)
