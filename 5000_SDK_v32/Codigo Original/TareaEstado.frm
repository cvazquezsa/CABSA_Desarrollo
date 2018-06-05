[Forma]
Clave=TareaEstado
Nombre=Estados de Tareas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=738
PosicionInicialArriba=445
PosicionInicialAltura=300
PosicionInicialAncho=451
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TareaEstado
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

[Lista.TareaEstado.Estado]
Carpeta=Lista
Clave=TareaEstado.Estado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
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
Orden=38
Estado=223
NombrePlural=190
EstadoOutlook=176

[Lista.TareaEstado.NombrePlural]
Carpeta=Lista
Clave=TareaEstado.NombrePlural
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
Visible=S
GuardarAntes=S
DespuesGuardar=S
AntesExpresiones=Forma(<T>TareaEstadoOrdenar<T>)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Ordenar
Ordenar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=TareaEstado.Estado
TareaEstado.Estado=TareaEstado.NombrePlural
TareaEstado.NombrePlural=(Fin)
