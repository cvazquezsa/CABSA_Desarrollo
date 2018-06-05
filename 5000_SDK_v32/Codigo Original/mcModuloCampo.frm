[Forma]
Clave=mcModuloCampo
Nombre=Campos del Módulo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Modulo
PosicionInicialIzquierda=645
PosicionInicialArriba=303
PosicionInicialAlturaCliente=557
PosicionInicialAncho=629
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=mcModuloCampo
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
CarpetaVisible=S
Filtros=S
PermiteEditar=S
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
OtroOrden=S
ListaOrden=mcModuloCampo.Campo<TAB>(Acendente)
HojaMantenerSeleccion=S
FiltroGeneral=mcModuloCampo.Modulo=<T>{Info.Modulo}<T>

[Lista.mcModuloCampo.Campo]
Carpeta=Lista
Clave=mcModuloCampo.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcModuloCampo.Nodo]
Carpeta=Lista
Clave=mcModuloCampo.Nodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
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
Campo=124
Nodo=352
TipoDatos=122
EsValor=43
RegistrarNombres=97
RegistrarPropiedades=114

[Lista.mcModuloCampo.RegistrarPropiedades]
Carpeta=Lista
Clave=mcModuloCampo.RegistrarPropiedades
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Propiedad]
Nombre=Propiedad
Boton=47
NombreEnBoton=S
NombreDesplegar=&Propiedad
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=mcModuloCampoProp
ActivoCondicion=mcModuloCampo:mcModuloCampo.RegistrarPropiedades
ConCondicion=S
EjecucionCondicion=ConDatos(mcModuloCampo:mcModuloCampo.Campo)
Antes=S
AntesExpresiones=Asigna(Info.Campo, mcModuloCampo:mcModuloCampo.Campo)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Propiedad
Propiedad=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=mcModuloCampo.Campo
mcModuloCampo.Campo=mcModuloCampo.Nodo
mcModuloCampo.Nodo=mcModuloCampo.RegistrarPropiedades
mcModuloCampo.RegistrarPropiedades=(Fin)
