[Forma]
Clave=VentaIntelisis
Nombre=Intelisis
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=136
PosicionInicialArriba=106
PosicionInicialAlturaCliente=522
PosicionInicialAncho=752
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Mov+<T> <T>+Info.MovID
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Ficha]
Estilo=Ficha
Pestana=S
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaIntelisis
Fuente={Tahoma, 8, Negro, []}
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
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)
FiltroGeneral=VentaIntelisis.ID={Info.ID}

[Ficha.VentaIntelisis.Descripcion]
Carpeta=Ficha
Clave=VentaIntelisis.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80x3
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaIntelisis.Ubicacion]
Carpeta=Ficha
Clave=VentaIntelisis.Ubicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaIntelisis.Respaldo]
Carpeta=Ficha
Clave=VentaIntelisis.Respaldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaIntelisis.Version]
Carpeta=Ficha
Clave=VentaIntelisis.Version
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.VentaIntelisis.ContactoSolicitante]
Carpeta=Ficha
Clave=VentaIntelisis.ContactoSolicitante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.VentaIntelisis.ContactoAutorizacion]
Carpeta=Ficha
Clave=VentaIntelisis.ContactoAutorizacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaIntelisis.ContactoFacturacion]
Carpeta=Ficha
Clave=VentaIntelisis.ContactoFacturacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaIntelisis.FechaSolicitud]
Carpeta=Ficha
Clave=VentaIntelisis.FechaSolicitud
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Ficha.VentaIntelisis.FechaRequerida]
Carpeta=Ficha
Clave=VentaIntelisis.FechaRequerida
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.VentaIntelisis.FechaAutorizacion]
Carpeta=Ficha
Clave=VentaIntelisis.FechaAutorizacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

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

[Problema]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Problema
Clave=Problema
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaIntelisis
Fuente={Tahoma, 8, Negro, []}
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
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)

[Problema.VentaIntelisis.Problema]
Carpeta=Problema
Clave=VentaIntelisis.Problema
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x9
ColorFondo=Blanco
ColorFuente=Negro
ConScroll=S

[Ficha.VentaIntelisis.ContactoDudas]
Carpeta=Ficha
Clave=VentaIntelisis.ContactoDudas
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.VentaIntelisis.FechaEntregaPrometida]
Carpeta=Ficha
Clave=VentaIntelisis.FechaEntregaPrometida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=$0080FFFF
ColorFuente=Negro

[Ficha.VentaIntelisis.FechaEntregaReal]
Carpeta=Ficha
Clave=VentaIntelisis.FechaEntregaReal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$0080FFFF
ColorFuente=Negro

[Ficha.VentaIntelisis.VersionEntrega]
Carpeta=Ficha
Clave=VentaIntelisis.VersionEntrega
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$0080FFFF
ColorFuente=Negro

[Solucion]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Solución
Clave=Solucion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaIntelisis
Fuente={Tahoma, 8, Negro, []}
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
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)

[Solucion.VentaIntelisis.SolucionActual]
Carpeta=Solucion
Clave=VentaIntelisis.SolucionActual
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=100x8
ColorFondo=Blanco
ColorFuente=Negro

[Solucion.VentaIntelisis.SolucionSugerida]
Carpeta=Solucion
Clave=VentaIntelisis.SolucionSugerida
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=100x9
ColorFondo=Blanco
ColorFuente=Negro

[Solucion.VentaIntelisis.Solucion]
Carpeta=Solucion
Clave=VentaIntelisis.Solucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=100x9
ColorFondo=$0080FFFF
ColorFuente=Negro

[Problema.VentaIntelisis.Layout]
Carpeta=Problema
Clave=VentaIntelisis.Layout
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=100x5
ColorFondo=Blanco
ColorFuente=Negro

[Problema.VentaIntelisis.Ejemplos]
Carpeta=Problema
Clave=VentaIntelisis.Ejemplos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
Tamano=100x5
ColorFondo=Blanco
ColorFuente=Negro

[Problema.VentaIntelisis.Filtros]
Carpeta=Problema
Clave=VentaIntelisis.Filtros
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100x5
ColorFondo=Blanco
ColorFuente=Negro

[Otros]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=Otros
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaIntelisis
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=$0080FFFF
ListaEnCaptura=(Lista)
CarpetaVisible=S
CondicionEdicion=Info.Estatus en (EstatusSinAfectar, EstatusPorConfirmar, EstatusPendiente)

[Otros.VentaIntelisis.Requerimientos]
Carpeta=Otros
Clave=VentaIntelisis.Requerimientos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=$0080FFFF
ColorFuente=Negro
ConScroll=S
Tamano=100x5

[Otros.VentaIntelisis.Instrucciones]
Carpeta=Otros
Clave=VentaIntelisis.Instrucciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=$0080FFFF
ColorFuente=Negro
ConScroll=S
Tamano=100x23

[Ficha.VentaIntelisis.AgenteProgramador]
Carpeta=Ficha
Clave=VentaIntelisis.AgenteProgramador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$0080FFFF
ColorFuente=Negro

[Ficha.Agente.Nombre]
Carpeta=Ficha
Clave=Agente.Nombre
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Ficha.VentaIntelisis.AgenteCalidad]
Carpeta=Ficha
Clave=VentaIntelisis.AgenteCalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$0080FFFF
ColorFuente=Negro

[Ficha.AgenteDestino.Nombre]
Carpeta=Ficha
Clave=AgenteDestino.Nombre
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
ValidaNombre=S

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Problema
Problema=Solucion
Solucion=Otros
Otros=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=VentaIntelisis.Descripcion
VentaIntelisis.Descripcion=VentaIntelisis.Ubicacion
VentaIntelisis.Ubicacion=VentaIntelisis.Version
VentaIntelisis.Version=VentaIntelisis.Respaldo
VentaIntelisis.Respaldo=VentaIntelisis.ContactoSolicitante
VentaIntelisis.ContactoSolicitante=VentaIntelisis.ContactoDudas
VentaIntelisis.ContactoDudas=VentaIntelisis.ContactoAutorizacion
VentaIntelisis.ContactoAutorizacion=VentaIntelisis.ContactoFacturacion
VentaIntelisis.ContactoFacturacion=VentaIntelisis.FechaSolicitud
VentaIntelisis.FechaSolicitud=VentaIntelisis.FechaRequerida
VentaIntelisis.FechaRequerida=VentaIntelisis.FechaAutorizacion
VentaIntelisis.FechaAutorizacion=VentaIntelisis.FechaEntregaPrometida
VentaIntelisis.FechaEntregaPrometida=VentaIntelisis.FechaEntregaReal
VentaIntelisis.FechaEntregaReal=VentaIntelisis.VersionEntrega
VentaIntelisis.VersionEntrega=VentaIntelisis.AgenteProgramador
VentaIntelisis.AgenteProgramador=Agente.Nombre
Agente.Nombre=VentaIntelisis.AgenteCalidad
VentaIntelisis.AgenteCalidad=AgenteDestino.Nombre
AgenteDestino.Nombre=(Fin)

[Problema.ListaEnCaptura]
(Inicio)=VentaIntelisis.Problema
VentaIntelisis.Problema=VentaIntelisis.Ejemplos
VentaIntelisis.Ejemplos=VentaIntelisis.Filtros
VentaIntelisis.Filtros=VentaIntelisis.Layout
VentaIntelisis.Layout=(Fin)

[Solucion.ListaEnCaptura]
(Inicio)=VentaIntelisis.SolucionActual
VentaIntelisis.SolucionActual=VentaIntelisis.SolucionSugerida
VentaIntelisis.SolucionSugerida=VentaIntelisis.Solucion
VentaIntelisis.Solucion=(Fin)

[Otros.ListaEnCaptura]
(Inicio)=VentaIntelisis.Requerimientos
VentaIntelisis.Requerimientos=VentaIntelisis.Instrucciones
VentaIntelisis.Instrucciones=(Fin)
