[Forma]
Clave=FormaTipoHTML
Nombre=Correo Electrónico
Icono=41
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Mensaje
PosicionInicialIzquierda=508
PosicionInicialArriba=198
PosicionInicialAlturaCliente=719
PosicionInicialAncho=882
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(FormaTipoHTML:FormaTipo.FormaTipo, FormaTipoHTML:FormaTipo.NombreCorto)
PosicionSec1=51

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

[Encuesta]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Encuesta
Clave=Encuesta
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=FormaTipoHTML
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
ListaEnCaptura=FormaTipo.CapturaHTML
CarpetaVisible=S
AlinearTodaCarpeta=S

[Encuesta.FormaTipo.CapturaHTML]
Carpeta=Encuesta
Clave=FormaTipo.CapturaHTML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro

[Confirmacion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Confirmación
Clave=Confirmacion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=FormaTipoHTML
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
ListaEnCaptura=FormaTipo.InfoHTML
CarpetaVisible=S
AlinearTodaCarpeta=S

[Confirmacion.FormaTipo.InfoHTML]
Carpeta=Confirmacion
Clave=FormaTipo.InfoHTML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=100x10
ColorFondo=Blanco
ColorFuente=Negro

[Mensaje]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mensaje
Clave=Mensaje
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=FormaTipoHTML
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
ListaEnCaptura=FormaTipo.MensajeHTML
CarpetaVisible=S
AlinearTodaCarpeta=S

[Mensaje.FormaTipo.MensajeHTML]
Carpeta=Mensaje
Clave=FormaTipo.MensajeHTML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=10x10
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaTipoHTML
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=FormaTipo.FormaTipo=<T>{Info.FormaTipo}<T>

[Ficha.FormaTipo.Asunto]
Carpeta=Ficha
Clave=FormaTipo.Asunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FormaTipo.ArchivoAdjunto]
Carpeta=Ficha
Clave=FormaTipo.ArchivoAdjunto
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.EditarMensaje]
Nombre=EditarMensaje
Boton=35
NombreEnBoton=S
NombreDesplegar=&Mensaje
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
GuardarAntes=S
Expresion=EditorHTML(FormaTipoHTML:FormaTipo.MensajeHTML, <T>Mensaje<T>, FormaTipoHTML:FormaTipo.FormaTipo)

[Acciones.Encuesta]
Nombre=Encuesta
Boton=35
NombreEnBoton=S
NombreDesplegar=&Encuesta
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=EditorHTML(FormaTipoHTML:FormaTipo.CapturaHTML, <T>Encuesta<T>, FormaTipoHTML:FormaTipo.FormaTipo)
Activo=S
Visible=S

[Acciones.Confirmacion]
Nombre=Confirmacion
Boton=35
NombreEnBoton=S
NombreDesplegar=&Confirmación
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Expresion=EditorHTML(FormaTipoHTML:FormaTipo.InfoHTML, <T>Confirmación<T>, FormaTipoHTML:FormaTipo.FormaTipo)
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Mensaje
Mensaje=Encuesta
Encuesta=Confirmacion
Confirmacion=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=EditarMensaje
EditarMensaje=Encuesta
Encuesta=Confirmacion
Confirmacion=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=FormaTipo.Asunto
FormaTipo.Asunto=FormaTipo.ArchivoAdjunto
FormaTipo.ArchivoAdjunto=(Fin)
