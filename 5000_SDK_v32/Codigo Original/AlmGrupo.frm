[Forma]
Clave=AlmGrupo
Nombre=Grupos de Almacenes
Icono=0
Modulos=INV
AccionesTamanoBoton=14x5
AccionesDerecha=S
ListaCarpetas=Lista
PosicionInicialIzquierda=171
PosicionInicialArriba=100
PosicionInicialAltura=345
PosicionInicialAncho=263
CarpetaPrincipal=Lista
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
PosicionInicialAlturaCliente=318

[AlmGrupo.Columnas]
Grupo=104
Descripcion=304

[Lista]
Estilo=Hoja
Pestana=
PestanaOtroNombre=
PestanaNombre=Lista
Clave=Lista
OtroOrden=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AlmGrupo
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=
HojaMostrarColumnas=
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=AlmGrupo.Grupo
ListaOrden=AlmGrupo.Grupo<TAB>(Acendente)
CarpetaVisible=S
CondicionEdicion=
HojaAjustarColumnas=S
PermiteEditar=S
HojaIndicador=
HojaConfirmarEliminar=S

[Lista.AlmGrupo.Grupo]
Carpeta=Lista
Clave=AlmGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Lista.Columnas]
Grupo=234
Descripcion=325

[Detalles.AlmGrupo.Grupo]
Carpeta=Detalles
Clave=AlmGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Detalles.AlmGrupo.Icono]
Carpeta=Detalles
Clave=AlmGrupo.Icono
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=S
Activo=S
GuardarAntes=S
ConCondicion=S
EjecucionConError=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(AlmGrupo:AlmGrupo.Grupo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
ActivoCondicion=Usuario.EnviarExcel
Visible=S

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Excel
Excel=(Fin)
