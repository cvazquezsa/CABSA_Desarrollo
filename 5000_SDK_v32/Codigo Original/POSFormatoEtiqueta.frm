
[Forma]
Clave=POSFormatoEtiqueta
Icono=0
CarpetaPrincipal=Nombre
Modulos=(Todos)
Nombre=POSFormatoEtiqueta


ListaCarpetas=(Lista)
PosicionInicialIzquierda=1857
PosicionInicialArriba=225
PosicionInicialAlturaCliente=536
PosicionInicialAncho=766
PosicionSec1=-32
PosicionCol1=248
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Nombre]
Estilo=Iconos
Clave=Nombre
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSFormatoEtiqueta
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Nombre<T>
IconosConRejilla=S
ElementosPorPaginaEsp=200
CampoColorLetras=Negro
CampoColorFondo=Negro
CarpetaVisible=S

PestanaOtroNombre=S
PestanaNombre=Etiquetas
OtroOrden=S
IconosNombre=POSFormatoEtiqueta:POSFormatoEtiqueta.Nombre
ListaOrden=POSFormatoEtiqueta.Nombre<TAB>(Acendente)
[POSFormatoEtiqueta]
Estilo=Ficha
Clave=POSFormatoEtiqueta
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=POSFormatoEtiqueta
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

GuardarPorRegistro=S
[POSFormatoEtiqueta.POSFormatoEtiqueta.EspecificarCopias]
Carpeta=POSFormatoEtiqueta
Clave=POSFormatoEtiqueta.EspecificarCopias
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=20
[POSFormatoEtiqueta.POSFormatoEtiqueta.Tipo]
Carpeta=POSFormatoEtiqueta
Clave=POSFormatoEtiqueta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Detalle.POSFormatoEtiqueta.Plantilla]
Carpeta=Detalle
Clave=POSFormatoEtiqueta.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Nombre.Columnas]
0=231





[POSFormatoEtiqueta.POSFormatoEtiqueta.Plantilla]
Carpeta=POSFormatoEtiqueta
Clave=POSFormatoEtiqueta.Plantilla
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=57x30
ColorFondo=Blanco













[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S



RefrescarDespues=S
DocNuevo=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
AntesExpresiones=ActualizarForma
[POSFormatoEtiqueta.POSFormatoEtiqueta.Nombre]
Carpeta=POSFormatoEtiqueta
Clave=POSFormatoEtiqueta.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco







[Acciones.Registro Insertar]
Nombre=Registro Insertar
Boton=1
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=POSFormatoEtiqueta
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S







GuardarAntes=S













EspacioPrevio=S
RefrescarDespues=S
[POSFormatoEtiqueta.ListaEnCaptura]
(Inicio)=POSFormatoEtiqueta.Nombre
POSFormatoEtiqueta.Nombre=POSFormatoEtiqueta.Tipo
POSFormatoEtiqueta.Tipo=POSFormatoEtiqueta.EspecificarCopias
POSFormatoEtiqueta.EspecificarCopias=POSFormatoEtiqueta.Plantilla
POSFormatoEtiqueta.Plantilla=(Fin)









[Acciones.Registro Eliminar]
Nombre=Registro Eliminar
Boton=5
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Nombre
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

















RefrescarDespues=S








DocNuevo=S






























[Acciones.Cerrar]
Nombre=Cerrar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarConfirmar=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S























[Forma.ListaCarpetas]
(Inicio)=Nombre
Nombre=POSFormatoEtiqueta
POSFormatoEtiqueta=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=Registro Insertar
Registro Insertar=Registro Eliminar
Registro Eliminar=(Fin)
