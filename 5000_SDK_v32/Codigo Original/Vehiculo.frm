[Forma]
Clave=Vehiculo
Nombre=Vehículos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=212
PosicionInicialArriba=316
PosicionInicialAltura=357
PosicionInicialAncho=856
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionColumna1=38
PosicionInicialAlturaCliente=358

[Lista]
Estilo=Hoja
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Vehiculo
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
HojaMantenerSeleccion=S

[Lista.Vehiculo.Vehiculo]
Carpeta=Lista
Clave=Vehiculo.Vehiculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Vehiculo.Descripcion]
Carpeta=Lista
Clave=Vehiculo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Vehiculo
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Vehiculo
Fuente={MS Sans Serif, 8, Negro, []}
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

[Detalle.Vehiculo.Vehiculo]
Carpeta=Detalle
Clave=Vehiculo.Vehiculo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.Vehiculo.Descripcion]
Carpeta=Detalle
Clave=Vehiculo.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Vehiculo.Placas]
Carpeta=Detalle
Clave=Vehiculo.Placas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Detalle.Vehiculo.Volumen]
Carpeta=Detalle
Clave=Vehiculo.Volumen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.Vehiculo.Peso]
Carpeta=Detalle
Clave=Vehiculo.Peso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Detalle.Vehiculo.Ruta]
Carpeta=Detalle
Clave=Vehiculo.Ruta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Lista.Columnas]
Vehiculo=100
Descripcion=189

[Acciones.Cerrar]
Nombre=Cerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(Vehiculo:Vehiculo.Vehiculo)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>
EjecucionConError=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ActivoCondicion=no Vehiculo:Vehiculo.TieneMovimientos

[Detalle.Vehiculo.Estatus]
Carpeta=Detalle
Clave=Vehiculo.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFuente=Negro
Pegado=S
ColorFondo=Blanco
EspacioPrevio=N

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=Propiedades
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=Prop
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(Vehiculo:Vehiculo.Vehiculo)
AntesExpresiones=Asigna(Info.Rama, <T>VEH<T>)<BR>Asigna(Info.Cuenta, Vehiculo:Vehiculo.Vehiculo)<BR>Asigna(Info.Descripcion, Vehiculo:Vehiculo.Descripcion)

[Acciones.Anexos]
Nombre=Anexos
Boton=77
NombreDesplegar=Ane&xos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(Vehiculo:Vehiculo.Vehiculo)
AntesExpresiones=Asigna(Info.Rama, <T>VEH<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Vehiculo:Vehiculo.Vehiculo)<BR>Asigna(Info.Descripcion, Vehiculo:Vehiculo.Descripcion)
RefrescarDespues=S

[Cxp.Vehiculo.Proveedor]
Carpeta=Cxp
Clave=Vehiculo.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.Prov.Nombre]
Carpeta=Cxp
Clave=Prov.Nombre
LineaNueva=N
3D=S
Tamano=33
ColorFondo=Plata
ColorFuente=Negro
Editar=S
Efectos=[Negritas]

[Cxp.Vehiculo.Condicion]
Carpeta=Cxp
Clave=Vehiculo.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.Vehiculo.Concepto]
Carpeta=Cxp
Clave=Vehiculo.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Cxp.Vehiculo.Vehiculo]
Carpeta=Cxp
Clave=Vehiculo.Vehiculo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Cxp.Vehiculo.Descripcion]
Carpeta=Cxp
Clave=Vehiculo.Descripcion
3D=S
Tamano=33
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Vehiculo.Proveedor]
Carpeta=Detalle
Clave=Vehiculo.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Prov.Nombre]
Carpeta=Detalle
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro

[Detalle.Vehiculo.GenerarGasto]
Carpeta=Detalle
Clave=Vehiculo.GenerarGasto
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Gasto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gasto
Clave=Gasto
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Vehiculo
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
CondicionVisible=Vehiculo:Vehiculo.GenerarGasto

[Gasto.Vehiculo.Vehiculo]
Carpeta=Gasto
Clave=Vehiculo.Vehiculo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Gasto.Vehiculo.Descripcion]
Carpeta=Gasto
Clave=Vehiculo.Descripcion
3D=S
Tamano=33
ColorFondo=Plata
ColorFuente=Negro

[Gasto.Vehiculo.Proveedor]
Carpeta=Gasto
Clave=Vehiculo.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.Prov.Nombre]
Carpeta=Gasto
Clave=Prov.Nombre
Editar=S
3D=S
Tamano=33
ColorFondo=Plata
ColorFuente=Negro

[Gasto.Vehiculo.Condicion]
Carpeta=Gasto
Clave=Vehiculo.Condicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.Vehiculo.Clase]
Carpeta=Gasto
Clave=Vehiculo.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.Vehiculo.Subclase]
Carpeta=Gasto
Clave=Vehiculo.Subclase
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[Gasto.Vehiculo.Impuestos]
Carpeta=Gasto
Clave=Vehiculo.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.Vehiculo.Retencion]
Carpeta=Gasto
Clave=Vehiculo.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Gasto.Vehiculo.Retencion2]
Carpeta=Gasto
Clave=Vehiculo.Retencion2
Editar=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[AF]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Activo Fijo
Clave=AF
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Vehiculo
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

[AF.Vehiculo.Vehiculo]
Carpeta=AF
Clave=Vehiculo.Vehiculo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[AF.Vehiculo.Descripcion]
Carpeta=AF
Clave=Vehiculo.Descripcion
Editar=N
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[AF.Vehiculo.Articulo]
Carpeta=AF
Clave=Vehiculo.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[AF.Art.Descripcion1]
Carpeta=AF
Clave=Art.Descripcion1
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Plata
ColorFuente=Negro

[AF.Vehiculo.Serie]
Carpeta=AF
Clave=Vehiculo.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agentes]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Agentes
Clave=Agentes
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Vehiculo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Agentes.Vehiculo.Agente]
Carpeta=Agentes
Clave=Vehiculo.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agentes.Agente.Nombre]
Carpeta=Agentes
Clave=Agente.Nombre
Editar=S
3D=S
Tamano=34
ColorFondo=Plata
ColorFuente=Negro

[Agentes.Vehiculo.Agente2]
Carpeta=Agentes
Clave=Vehiculo.Agente2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Agentes.Vehiculo.Agente3]
Carpeta=Agentes
Clave=Vehiculo.Agente3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Vehiculo.RendimientoCombustible]
Carpeta=Detalle
Clave=Vehiculo.RendimientoCombustible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.Vehiculo.RendimientoTermo]
Carpeta=Detalle
Clave=Vehiculo.RendimientoTermo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=OtrosDatos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=Vehiculo
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

[OtrosDatos.Vehiculo.Descripcion1]
Carpeta=OtrosDatos
Clave=Vehiculo.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Vehiculo.Descripcion2]
Carpeta=OtrosDatos
Clave=Vehiculo.Descripcion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Vehiculo.Descripcion3]
Carpeta=OtrosDatos
Clave=Vehiculo.Descripcion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Vehiculo.Descripcion4]
Carpeta=OtrosDatos
Clave=Vehiculo.Descripcion4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[OtrosDatos.Vehiculo.Descripcion5]
Carpeta=OtrosDatos
Clave=Vehiculo.Descripcion5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Agentes.AgenteDestino.Nombre]
Carpeta=Agentes
Clave=AgenteDestino.Nombre
Editar=S
3D=S
Tamano=34
ColorFondo=Plata
ColorFuente=Negro

[Agentes.AgenteDetalle.Nombre]
Carpeta=Agentes
Clave=AgenteDetalle.Nombre
Editar=S
3D=S
Tamano=34
ColorFondo=Plata
ColorFuente=Negro

[Gasto.Vehiculo.Retencion3]
Carpeta=Gasto
Clave=Vehiculo.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=Agentes
Agentes=Gasto
Gasto=AF
AF=OtrosDatos
OtrosDatos=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Nuevo
Nuevo=Eliminar
Eliminar=Propiedades
Propiedades=Anexos
Anexos=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Vehiculo.Vehiculo
Vehiculo.Vehiculo=Vehiculo.Descripcion
Vehiculo.Descripcion=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=Vehiculo.Vehiculo
Vehiculo.Vehiculo=Vehiculo.Estatus
Vehiculo.Estatus=Vehiculo.Descripcion
Vehiculo.Descripcion=Vehiculo.Placas
Vehiculo.Placas=Vehiculo.Volumen
Vehiculo.Volumen=Vehiculo.Peso
Vehiculo.Peso=Vehiculo.RendimientoCombustible
Vehiculo.RendimientoCombustible=Vehiculo.RendimientoTermo
Vehiculo.RendimientoTermo=Vehiculo.Ruta
Vehiculo.Ruta=Vehiculo.Proveedor
Vehiculo.Proveedor=Prov.Nombre
Prov.Nombre=Vehiculo.GenerarGasto
Vehiculo.GenerarGasto=(Fin)

[Gasto.ListaEnCaptura]
(Inicio)=Vehiculo.Vehiculo
Vehiculo.Vehiculo=Vehiculo.Descripcion
Vehiculo.Descripcion=Vehiculo.Proveedor
Vehiculo.Proveedor=Prov.Nombre
Prov.Nombre=Vehiculo.Condicion
Vehiculo.Condicion=Vehiculo.Clase
Vehiculo.Clase=Vehiculo.Subclase
Vehiculo.Subclase=Vehiculo.Impuestos
Vehiculo.Impuestos=Vehiculo.Retencion
Vehiculo.Retencion=Vehiculo.Retencion2
Vehiculo.Retencion2=Vehiculo.Retencion3
Vehiculo.Retencion3=(Fin)

[AF.ListaEnCaptura]
(Inicio)=Vehiculo.Vehiculo
Vehiculo.Vehiculo=Vehiculo.Descripcion
Vehiculo.Descripcion=Vehiculo.Articulo
Vehiculo.Articulo=Art.Descripcion1
Art.Descripcion1=Vehiculo.Serie
Vehiculo.Serie=(Fin)

[Agentes.ListaEnCaptura]
(Inicio)=Vehiculo.Agente
Vehiculo.Agente=Agente.Nombre
Agente.Nombre=Vehiculo.Agente2
Vehiculo.Agente2=AgenteDestino.Nombre
AgenteDestino.Nombre=Vehiculo.Agente3
Vehiculo.Agente3=AgenteDetalle.Nombre
AgenteDetalle.Nombre=(Fin)

[OtrosDatos.ListaEnCaptura]
(Inicio)=Vehiculo.Descripcion1
Vehiculo.Descripcion1=Vehiculo.Descripcion2
Vehiculo.Descripcion2=Vehiculo.Descripcion3
Vehiculo.Descripcion3=Vehiculo.Descripcion4
Vehiculo.Descripcion4=Vehiculo.Descripcion5
Vehiculo.Descripcion5=(Fin)
