[Forma]
Clave=ProyectoDesarrolloClase1
Nombre=Clasificación
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=699
PosicionInicialArriba=356
PosicionInicialAlturaCliente=451
PosicionInicialAncho=530

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Clase2]
Nombre=Clase2
Boton=91
NombreEnBoton=S
NombreDesplegar=&Sub Clasificación
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ProyectoDesarrolloClase2
Activo=S
Visible=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Clase1, ProyectoDesarrolloClase1:ProyectoDesarrolloClase1.Clase1)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ProyectoDesarrolloClase1
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
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=ProyectoDesarrolloClase1.Orden<TAB>(Acendente)
ValidarCampos=S
ListaCamposAValidar=Recurso.Nombre

[Lista.ProyectoDesarrolloClase1.Clase1]
Carpeta=Lista
Clave=ProyectoDesarrolloClase1.Clase1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Clase1=324
Supervisor=124
Nombre=304
Orden=41

[Lista.ProyectoDesarrolloClase1.Supervisor]
Carpeta=Lista
Clave=ProyectoDesarrolloClase1.Supervisor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ProyectoDesarrolloClase1.Orden]
Carpeta=Lista
Clave=ProyectoDesarrolloClase1.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Clase2
Clase2=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=ProyectoDesarrolloClase1.Clase1
ProyectoDesarrolloClase1.Clase1=ProyectoDesarrolloClase1.Supervisor
ProyectoDesarrolloClase1.Supervisor=ProyectoDesarrolloClase1.Orden
ProyectoDesarrolloClase1.Orden=(Fin)
