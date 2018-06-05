[Forma]
Clave=ConceptoAcreedor
Nombre=Acreedores del Concepto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=437
PosicionInicialArriba=337
PosicionInicialAlturaCliente=323
PosicionInicialAncho=470
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Concepto
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ConceptoAcreedor
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=ConceptoAcreedor.Modulo=<T>{Info.Modulo}<T> AND ConceptoAcreedor.Concepto=<T>{Info.Concepto}<T>

[Lista.Columnas]
Usuario=83
Nombre=292
Acreedor=83
porOmision=64

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

[Lista.ConceptoAcreedor.Acreedor]
Carpeta=Lista
Clave=ConceptoAcreedor.Acreedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Acreedor.Nombre]
Carpeta=Lista
Clave=Acreedor.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ConceptoAcreedor.porOmision]
Carpeta=Lista
Clave=ConceptoAcreedor.porOmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=ConceptoAcreedor.Acreedor
ConceptoAcreedor.Acreedor=Acreedor.Nombre
Acreedor.Nombre=ConceptoAcreedor.porOmision
ConceptoAcreedor.porOmision=(Fin)
