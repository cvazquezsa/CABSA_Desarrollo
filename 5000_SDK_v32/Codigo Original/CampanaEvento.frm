[Forma]
Clave=CampanaEvento
Nombre=Agregar Evento
Icono=0
IniciarAgregando=S
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=649
PosicionInicialArriba=459
PosicionInicialAlturaCliente=246
PosicionInicialAncho=622
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Clave, Info.Nombre)  
VentanaExclusiva=S
VentanaEstadoInicial=Normal

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaEvento
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
CondicionEdicion=Info.PuedeEditar
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales

[Ficha.CampanaEvento.Tipo]
Carpeta=Ficha
Clave=CampanaEvento.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaEvento.Situacion]
Carpeta=Ficha
Clave=CampanaEvento.Situacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Ficha.CampanaEvento.Observaciones]
Carpeta=Ficha
Clave=CampanaEvento.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70x5
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaEvento.FechaHora]
Carpeta=Ficha
Clave=CampanaEvento.FechaHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=25
EspacioPrevio=S

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Info.Situacion, CampanaEvento:CampanaEvento.Situacion)<BR>Asigna(Info.SituacionFecha, CampanaEvento:CampanaEvento.SituacionFecha)<BR>Asigna(Info.Observaciones, CampanaEvento:CampanaEvento.Observaciones)<BR>Verdadero

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Ficha.CampanaEvento.SituacionFecha]
Carpeta=Ficha
Clave=CampanaEvento.SituacionFecha
Editar=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Comentarios]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Comentarios
Clave=Comentarios
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaEvento
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
ListaEnCaptura=CampanaEvento.Comentarios
CarpetaVisible=S
AlinearTodaCarpeta=S

[Comentarios.CampanaEvento.Comentarios]
Carpeta=Comentarios
Clave=CampanaEvento.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255x3
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Comentarios
Comentarios=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CampanaEvento.Tipo
CampanaEvento.Tipo=CampanaEvento.Observaciones
CampanaEvento.Observaciones=CampanaEvento.Situacion
CampanaEvento.Situacion=CampanaEvento.SituacionFecha
CampanaEvento.SituacionFecha=CampanaEvento.FechaHora
CampanaEvento.FechaHora=(Fin)
