[Forma]
Clave=MovPropiedades
Nombre=Propiedades del Movimiento
Icono=0
Modulos=(Todos)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=695
PosicionInicialArriba=369
PosicionInicialAltura=429
PosicionInicialAncho=536
BarraAcciones=S
AccionesTamanoBoton=11x5
AccionesDerecha=S
ListaAcciones=(Lista)
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=425

[Ficha]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Propiedades
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Mov
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=8
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Mov.Empresa=<T>{Empresa}<T> AND<BR>Mov.Modulo=<T>{Info.Modulo}<T> AND<BR>Mov.ID={Info.ID}
CondicionVisible=ConDatos(Mov:Mov.ID)

[Ficha.Mov.Ejercicio]
Carpeta=Ficha
Clave=Mov.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
ColorFondo=Plata
EspacioPrevio=N
ColorFuente=Negro

[Ficha.Mov.Periodo]
Carpeta=Ficha
Clave=Mov.Periodo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Mov.FechaRegistro]
Carpeta=Ficha
Clave=Mov.FechaRegistro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
ColorFondo=Plata
Tamano=40
EspacioPrevio=N
ColorFuente=Negro

[Ficha.Mov.FechaEmision]
Carpeta=Ficha
Clave=Mov.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
ColorFondo=Plata
Tamano=40
EspacioPrevio=S
ColorFuente=Negro

[Ficha.Mov.Concepto]
Carpeta=Ficha
Clave=Mov.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=40
ColorFondo=Plata
EspacioPrevio=S
ColorFuente=Negro

[Ficha.Mov.Proyecto]
Carpeta=Ficha
Clave=Mov.Proyecto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=40
ColorFondo=Plata
EspacioPrevio=S
ColorFuente=Negro

[Ficha.Mov.Moneda]
Carpeta=Ficha
Clave=Mov.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Mov.TipoCambio]
Carpeta=Ficha
Clave=Mov.TipoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
ColorFondo=Plata
Tamano=10
ColorFuente=Negro

[Ficha.Mov.Usuario]
Carpeta=Ficha
Clave=Mov.Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=10
ColorFondo=Plata
EspacioPrevio=S
ColorFuente=Negro

[Ficha.Mov.Referencia]
Carpeta=Ficha
Clave=Mov.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Mov.Observaciones]
Carpeta=Ficha
Clave=Mov.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=N
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=&Cerrar
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Examinar]
Nombre=Examinar
Boton=0
NombreDesplegar=&Examinar
EnBarraAcciones=S
TipoAccion=Expresion
Visible=S
Expresion=ReportePantalla(Info.Modulo, Info.ID)
ActivoCondicion=ConDatos(Mov:Mov.ID)

[Acciones.Posicion]
Nombre=Posicion
Boton=0
NombreDesplegar=&Posición
EnBarraAcciones=S
TipoAccion=Expresion
Visible=S
Antes=S

Expresion=SI General.MovPosicionAnterior Entonces<BR>  Forma(<T>MovPos<T>)<BR>SINO<BR>  EJECUTARSQL(<T>EXEC spMovPos :nEstacion, :tModulo, :tModuloID<T>, EstacionTrabajo, Info.Modulo, Info.ID)<BR>  Forma(<T>MovPosArbol<T>)<BR>FIN
ActivoCondicion=ConDatos(Mov:Mov.MovID)
AntesExpresiones=Asigna(Info.MovID, Mov:Mov.MovID)<BR>Asigna(Info.Mov, Mov:Mov.Mov)<BR>Asigna(Info.Modulo, Mov:Mov.Modulo)<BR>Asigna(Info.ID, Mov:Mov.ID)
[(Variables)]
Estilo=Ficha
Pestana=S
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Negro
CarpetaVisible=
PestanaOtroNombre=S
PestanaNombre=Movimiento sin Afectar
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Plata
CondicionVisible=Vacio(Mov:Mov.ID)

[Ficha.Movimiento]
Carpeta=Ficha
Clave=Movimiento
Editar=S
LineaNueva=S
Tamano=55
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Ficha.MovimientoPoliza]
Carpeta=Ficha
Clave=MovimientoPoliza
Editar=S
LineaNueva=S
ValidaNombre=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Mov.ID]
Carpeta=Ficha
Clave=Mov.ID
Editar=S
Tamano=13
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Usuarios]
Nombre=Usuarios
Boton=0
NombreDesplegar=&Usuarios
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=MovEstatusLog
Visible=S
Antes=S
ActivoCondicion=ConDatos(Mov:Mov.ID)
AntesExpresiones=Asigna(Info.ID, Mov:Mov.ID)<BR>Asigna(Info.Modulo, Mov:Mov.Modulo)<BR>Asigna(Info.Mov, Mov:Mov.Mov)<BR>Asigna(Info.MovID, Mov:Mov.MovID)

[Acciones.Poliza]
Nombre=Poliza
Boton=0
NombreDesplegar=Póli&za
EnBarraAcciones=S
TipoAccion=Expresion
Visible=S
Expresion=ReportePantalla(<T>CONT<T>, Mov:Mov.ContID)
ActivoCondicion=ConDatos(Mov:Mov.ContID)

[Acciones.Tiempos]
Nombre=Tiempos
Boton=0
NombreDesplegar=&Tiempos
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=VerMovTiempo
Visible=S
Antes=S
ActivoCondicion=ConDatos(Mov:Mov.ID) y (ConfigModulo(Mov:Mov.Modulo, <T>Tiempos<T>)=<T>Si<T>)
AntesExpresiones=Asigna(Info.ID, Mov:Mov.ID)<BR>Asigna(Info.Modulo, Mov:Mov.Modulo)<BR>Asigna(Info.Mov, Mov:Mov.Mov)<BR>Asigna(Info.MovID, Mov:Mov.MovID)

[Ficha.Mov.Turno]
Carpeta=Ficha
Clave=Mov.Turno
Editar=S
LineaNueva=S
ValidaNombre=S
Tamano=10
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Anexos]
Nombre=Anexos
Boton=0
NombreDesplegar=Ane&xos
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=AnexoMov
Antes=S
Visible=S
ActivoCondicion=ConDatos(Mov:Mov.ID)
AntesExpresiones=Asigna(Info.Rama, Mov:Mov.Modulo)<BR>Asigna(Info.Fecha, Mov:Mov.FechaEmision)<BR>Asigna(Info.ID, Mov:Mov.ID)<BR>Asigna(Info.AnexoCfg, falso)<BR>Asigna(Info.Descripcion, Mov:Mov.Mov+<T> <T>+Mov:Mov.MovID)
RefrescarDespues=S

[Acciones.Tareas]
Nombre=Tareas
Boton=0
NombreDesplegar=&Tareas
EnBarraAcciones=S
TipoAccion=Formas
ClaveAccion=Tarea
Visible=S
Antes=S
ActivoCondicion=ConDatos(Mov:Mov.ID)
AntesExpresiones=Asigna(Info.ID, Mov:Mov.ID)<BR>Asigna(Info.Modulo, Mov:Mov.Modulo)<BR>Asigna(Info.Mov, Mov:Mov.Mov)<BR>Asigna(Info.MovID, Mov:Mov.MovID)<BR>Asigna(Info.PuedeEditar, Falso)



[Ficha.ListaEnCaptura]
(Inicio)=Movimiento
Movimiento=Mov.ID
Mov.ID=Mov.Concepto
Mov.Concepto=Mov.Referencia
Mov.Referencia=Mov.Observaciones
Mov.Observaciones=Mov.FechaEmision
Mov.FechaEmision=Mov.FechaRegistro
Mov.FechaRegistro=Mov.Ejercicio
Mov.Ejercicio=Mov.Periodo
Mov.Periodo=Mov.Proyecto
Mov.Proyecto=Mov.Moneda
Mov.Moneda=Mov.TipoCambio
Mov.TipoCambio=Mov.Usuario
Mov.Usuario=Mov.Turno
Mov.Turno=MovimientoPoliza
MovimientoPoliza=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=(Variables)
(Variables)=(Fin)

[Forma.ListaAcciones]
(Inicio)=Posicion
Posicion=Examinar
Examinar=Anexos
Anexos=Poliza
Poliza=Usuarios
Usuarios=Tareas
Tareas=Tiempos
Tiempos=Cerrar
Cerrar=(Fin)
