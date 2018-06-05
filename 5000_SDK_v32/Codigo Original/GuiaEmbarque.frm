[Forma]
Clave=GuiaEmbarque
Nombre=e(<T>Datos Embarque<T>)+<T> - <T>+Info.Mov+<T> <T>+Info.MovID
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Envio
PosicionInicialIzquierda=284
PosicionInicialArriba=237
PosicionInicialAltura=286
PosicionInicialAncho=456
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionColumna1=52
VentanaExclusiva=S
PosicionSeccion1=76
VentanaEscCerrar=S
PosicionInicialAlturaCliente=259

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
GuardarAntes=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(GuiaEmbarqueD:GuiaEmbarqueD.Guia)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=<T>Guía: <T>+Temp.Texto+<T> Duplicado<T>
Antes=S
AntesExpresiones=Si(Vacio(GuiaEmbarque:GuiaEmbarque.FechaEnvio), Asigna(GuiaEmbarque:GuiaEmbarque.FechaEnvio, Ahora))

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=GuiaEmbarqueD
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
ListaEnCaptura=GuiaEmbarqueD.Guia
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Guías de Embarque
Detalle=S
VistaMaestra=GuiaEmbarque
LlaveLocal=(Lista)
LlaveMaestra=GuiaEmbarque.Modulo<BR>GuiaEmbarque.ID

[Lista.Columnas]
Guia=184

[Envio]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Fechas
Clave=Envio
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GuiaEmbarque
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=GuiaEmbarque.Modulo=<T>{Info.Modulo}<T> AND<BR>GuiaEmbarque.ID={Info.ID}

[Envio.GuiaEmbarque.FechaEnvio]
Carpeta=Envio
Clave=GuiaEmbarque.FechaEnvio
Editar=S
EditarConBloqueo=N
ValidaNombre=S
3D=S
Tamano=30
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro

[Envio.GuiaEmbarque.FormaEnvio]
Carpeta=Envio
Clave=GuiaEmbarque.FormaEnvio
Editar=S
EditarConBloqueo=N
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=S
ColorFondo=Blanco
ColorFuente=Negro

[Envio.GuiaEmbarque.Paquetes]
Carpeta=Envio
Clave=GuiaEmbarque.Paquetes
Editar=S
EditarConBloqueo=N
ValidaNombre=S
3D=S
Tamano=9
LineaNueva=N
ColorFondo=Blanco
ColorFuente=Negro

[Recibio]
Estilo=Ficha
Clave=Recibio
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=GuiaEmbarque
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Recibio.GuiaEmbarque.FechaRecepcion]
Carpeta=Recibio
Clave=GuiaEmbarque.FechaRecepcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30

[Recibio.GuiaEmbarque.PersonaRecibio]
Carpeta=Recibio
Clave=GuiaEmbarque.PersonaRecibio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=30

[Lista.GuiaEmbarqueD.Guia]
Carpeta=Lista
Clave=GuiaEmbarqueD.Guia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Asistente]
Nombre=Asistente
Boton=12
NombreEnBoton=S
NombreDesplegar=&Asistente
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Wizards
ClaveAccion=Asistente Series/Lotes
ListaParametros1=GuiaEmbarqueD:GuiaEmbarqueD.Guia
ListaParametros=S
Activo=S
Visible=S

[Acciones.Cerrar.Fecha]
Nombre=Fecha
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

[Acciones.Cerrar.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Cerrar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Envio
Envio=Lista
Lista=Recibio
Recibio=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Asistente
Asistente=(Fin)

[Lista.LlaveLocal]
(Inicio)=GuiaEmbarqueD.Modulo
GuiaEmbarqueD.Modulo=GuiaEmbarqueD.ID
GuiaEmbarqueD.ID=(Fin)

[Envio.ListaEnCaptura]
(Inicio)=GuiaEmbarque.FechaEnvio
GuiaEmbarque.FechaEnvio=GuiaEmbarque.FormaEnvio
GuiaEmbarque.FormaEnvio=GuiaEmbarque.Paquetes
GuiaEmbarque.Paquetes=(Fin)

[Recibio.ListaEnCaptura]
(Inicio)=GuiaEmbarque.FechaRecepcion
GuiaEmbarque.FechaRecepcion=GuiaEmbarque.PersonaRecibio
GuiaEmbarque.PersonaRecibio=(Fin)
