[Forma]
Clave=Version
Nombre=Configuración - Base Datos
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=253
PosicionInicialArriba=5
PosicionInicialAlturaCliente=680
PosicionInicialAncho=860
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Generales

[Ficha.Version.RedondeoMonetarios]
Carpeta=Ficha
Clave=Version.RedondeoMonetarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=5
Pegado=N

[Ficha.Version.Peru]
Carpeta=Ficha
Clave=Version.Peru
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=30
EspacioPrevio=N

[Ficha.Version.NomLimiteInferior2]
Carpeta=Ficha
Clave=Version.NomLimiteInferior2
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=40

[Ficha.Version.OutlookEstatusNuevo]
Carpeta=Ficha
Clave=Version.OutlookEstatusNuevo
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=40
EspacioPrevio=S

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
ConCondicion=S
EjecucionCondicion=Si(Vacio(Version:Version.Base), Error(<T>Falta Especificar el Nombre de la Base<T>) AbortarOperacion)<BR>Si(Version:Version.Sincro y Version:Version.ModuloCentral, Error(<T>El Módulo Central Sustituye a la Sincronizacion<T>) AbortarOperacion)
Antes=S
AntesExpresiones=EjecutarSQL(<T>spCfgModuloCentralReplica<T>)
DespuesGuardar=S

[Ficha.Version.NombreCorreoEnLote]
Carpeta=Ficha
Clave=Version.NombreCorreoEnLote
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Contrasena]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contraseña
Clave=Contrasena
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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

[Contrasena.Version.ContrasenaTamanoMinimo]
Carpeta=Contrasena
Clave=Version.ContrasenaTamanoMinimo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Contrasena.Version.ContrasenaRequiereAlfa]
Carpeta=Contrasena
Clave=Version.ContrasenaRequiereAlfa
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Contrasena.Version.ContrasenaRequiereNumeros]
Carpeta=Contrasena
Clave=Version.ContrasenaRequiereNumeros
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Outlook]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Outlook
Clave=Outlook
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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

[Outlook.Version.OutlookMensajes]
Carpeta=Outlook
Clave=Version.OutlookMensajes
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Outlook.Version.OutlookCitas]
Carpeta=Outlook
Clave=Version.OutlookCitas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Outlook.Version.OutlookTareas]
Carpeta=Outlook
Clave=Version.OutlookTareas
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20
EspacioPrevio=S

[Outlook.Version.OutlookTareasSincronizar]
Carpeta=Outlook
Clave=Version.OutlookTareasSincronizar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Version.SituacionFinalAlRegresar]
Carpeta=Ficha
Clave=Version.SituacionFinalAlRegresar
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
Tamano=30
EspacioPrevio=S

[Outlook.Version.OutlookActividadesSincronizar]
Carpeta=Outlook
Clave=Version.OutlookActividadesSincronizar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Version.ModuloCentral]
Carpeta=Ficha
Clave=Version.ModuloCentral
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[ModuloCentral]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Módulo Central
Clave=ModuloCentral
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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
CondicionVisible=Version:Version.ModuloCentral

[ModuloCentral.Version.ModuloCentralURL]
Carpeta=ModuloCentral
Clave=Version.ModuloCentralURL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=51
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[BaseDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Base Datos
Clave=BaseDatos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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
ListaEnCaptura=Version.Base
CarpetaVisible=S

[BaseDatos.Version.Base]
Carpeta=BaseDatos
Clave=Version.Base
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[ModuloCentral.Version.Desconectar]
Carpeta=ModuloCentral
Clave=Version.Desconectar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[ModuloCentral.Version.Reconectar]
Carpeta=ModuloCentral
Clave=Version.Reconectar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[ModuloCentral.Version.EstaDesconectado]
Carpeta=ModuloCentral
Clave=Version.EstaDesconectado
Editar=S
LineaNueva=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[ModuloCentral.Version.FechaDesconexion]
Carpeta=ModuloCentral
Clave=Version.FechaDesconexion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro
EspacioPrevio=S

[ModuloCentral.Version.ReconexionFrecuencia]
Carpeta=ModuloCentral
Clave=Version.ReconexionFrecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[ModuloCentral.Version.ReconexionUltimoIntento]
Carpeta=ModuloCentral
Clave=Version.ReconexionUltimoIntento
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
ColorFuente=Negro

[ModuloCentral.Version.ConservarColaProcesada]
Carpeta=ModuloCentral
Clave=Version.ConservarColaProcesada
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=N

[Acciones.CacheCola]
Nombre=CacheCola
Boton=45
NombreEnBoton=S
NombreDesplegar=&Colas / Caché
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CfgModuloCentralAccion
Visible=S
ActivoCondicion=Version:Version.ModuloCentral

[ModuloCentral.Version.TamanoLoteProcesarCola]
Carpeta=ModuloCentral
Clave=Version.TamanoLoteProcesarCola
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[ModuloCentral.Version.Replica]
Carpeta=ModuloCentral
Clave=Version.Replica
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Replica]
Nombre=Replica
Boton=45
NombreEnBoton=S
NombreDesplegar=&Replica
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CfgModuloCentralReplica
Visible=S
ActivoCondicion=Version:Version.ModuloCentral y Version:Version.Replica

[ModuloCentral.Version.TamanoLoteProcesarReplica]
Carpeta=ModuloCentral
Clave=Version.TamanoLoteProcesarReplica
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[ModuloCentral.Version.ConservarReplicaProcesada]
Carpeta=ModuloCentral
Clave=Version.ConservarReplicaProcesada
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Version.SincroSSB]
Carpeta=Ficha
Clave=Version.SincroSSB
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=40
ColorFondo=Blanco
EspacioPrevio=N

[SincroSSB]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Sincronización (Service Broker)
Clave=SincroSSB
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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
PermiteEditar=S
CondicionVisible=Version:Version.SincroSSB

[SincroSSB.Version.SincroSBBOkConservar]
Carpeta=SincroSSB
Clave=Version.SincroSBBOkConservar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
EspacioPrevio=N

[SincroSSB.Version.SincroSSBModoManual]
Carpeta=SincroSSB
Clave=Version.SincroSSBModoManual
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[SincroSSB.Version.SincroContabilidadMatriz]
Carpeta=SincroSSB
Clave=Version.SincroContabilidadMatriz
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Acciones.Certificados]
Nombre=Certificados
Boton=69
NombreEnBoton=S
NombreDesplegar=Actualizar &Certificados
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=VerComentario( <T>Script para Activar Certificados<T>, SQLEnLista(<T>spSincroSSB_ActualizarCertificados<T>))
ActivoCondicion=Version:Version.SincroSSB y (no Version:Version.SincroSSBMismaInstancia)

[Ficha.Version.PuertoSSB]
Carpeta=Ficha
Clave=Version.PuertoSSB
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=10

[Ficha.Version.RutaCertificados]
Carpeta=Ficha
Clave=Version.RutaCertificados
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco

[Ficha.Version.SincroSSBMismaInstancia]
Carpeta=Ficha
Clave=Version.SincroSSBMismaInstancia
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[Acciones.Respaldo]
Nombre=Respaldo
Boton=94
NombreEnBoton=S
NombreDesplegar=Solicitar &Respaldo
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
EspacioPrevio=S
Expresion=Si(Version:Version.SincroSSB,ProcesarSQL(<T>spSincroSSB_SolicitarRespaldo<T>),Si(Version:Version.SincroIS,ADO.EjecutarSQL(<T>Sincronización...<T>,<T>EXEC spSincroIS_SolicitarRespaldo <T> & Comillas(Usuario))))
ActivoCondicion=((Version:Version.SincroSSB y (no Version:Version.SincroSSBMismaInstancia)) o (Version:Version.SincroIS)) y (Version:Version.Sucursal>0)

[SincroSSB.Version.SincroSSBRecibirRespaldoMatriz]
Carpeta=SincroSSB
Clave=Version.SincroSSBRecibirRespaldoMatriz
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[SincroSSB.Version.TRCL]
Carpeta=SincroSSB
Clave=Version.TRCL
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=40
ColorFondo=Blanco

[Ficha.Version.IPDinamica]
Carpeta=Ficha
Clave=Version.IPDinamica
Editar=S
LineaNueva=S
3D=S
Tamano=40
ColorFondo=Blanco

[IPDinamica]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=IP Dinámica
Clave=IPDinamica
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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
CondicionVisible=Version:Version.IPDinamica y (Version:Version.Sucursal>0)

[IPDinamica.Version.IPDinamicaURL]
Carpeta=IPDinamica
Clave=Version.IPDinamicaURL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[IPDinamica.Version.IPDinamicaPrefijo]
Carpeta=IPDinamica
Clave=Version.IPDinamicaPrefijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[IPDinamica.Version.IPDinamicaSufijo]
Carpeta=IPDinamica
Clave=Version.IPDinamicaSufijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Version.RegHist]
Carpeta=Ficha
Clave=Version.RegHist
Editar=S
LineaNueva=N
3D=S
EspacioPrevio=N
Tamano=40
ColorFondo=Blanco

[Acciones.CfgRegHist]
Nombre=CfgRegHist
Boton=53
NombreDesplegar=Reg. &Hist
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CfgRegHist
Visible=S
EspacioPrevio=S
ActivoCondicion=Version:Version.RegHist

[Contrasena.ListaEnCaptura]
(Inicio)=Version.ContrasenaTamanoMinimo
Version.ContrasenaTamanoMinimo=Version.ContrasenaRequiereAlfa
Version.ContrasenaRequiereAlfa=Version.ContrasenaRequiereNumeros
Version.ContrasenaRequiereNumeros=(Fin)

[Outlook.ListaEnCaptura]
(Inicio)=Version.OutlookMensajes
Version.OutlookMensajes=Version.OutlookCitas
Version.OutlookCitas=Version.OutlookTareas
Version.OutlookTareas=Version.OutlookTareasSincronizar
Version.OutlookTareasSincronizar=Version.OutlookActividadesSincronizar
Version.OutlookActividadesSincronizar=(Fin)

[ModuloCentral.ListaEnCaptura]
(Inicio)=Version.ModuloCentralURL
Version.ModuloCentralURL=Version.Desconectar
Version.Desconectar=Version.Reconectar
Version.Reconectar=Version.EstaDesconectado
Version.EstaDesconectado=Version.FechaDesconexion
Version.FechaDesconexion=Version.ReconexionUltimoIntento
Version.ReconexionUltimoIntento=Version.ReconexionFrecuencia
Version.ReconexionFrecuencia=Version.TamanoLoteProcesarCola
Version.TamanoLoteProcesarCola=Version.ConservarColaProcesada
Version.ConservarColaProcesada=Version.Replica
Version.Replica=Version.TamanoLoteProcesarReplica
Version.TamanoLoteProcesarReplica=Version.ConservarReplicaProcesada
Version.ConservarReplicaProcesada=(Fin)

[IPDinamica.ListaEnCaptura]
(Inicio)=Version.IPDinamicaURL
Version.IPDinamicaURL=Version.IPDinamicaPrefijo
Version.IPDinamicaPrefijo=Version.IPDinamicaSufijo
Version.IPDinamicaSufijo=(Fin)

[Ficha.Version.Impuesto2Info]
Carpeta=Ficha
Clave=Version.Impuesto2Info
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco

[Ficha.Version.Impuesto3Info]
Carpeta=Ficha
Clave=Version.Impuesto3Info
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Version.Retencion2BaseImpuesto1]
Carpeta=Ficha
Clave=Version.Retencion2BaseImpuesto1
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Version.FK]
Carpeta=Ficha
Clave=Version.FK
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[Ficha.Version.Impuesto2BaseImpuesto1]
Carpeta=Ficha
Clave=Version.Impuesto2BaseImpuesto1
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
EspacioPrevio=S

[SincroIS]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Sincronización (Intelisis Service)
Clave=SincroIS
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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

CondicionVisible=Version:Version.SincroIS
[SincroIS.Version.SincroISRecibirRespaldoMatriz]
Carpeta=SincroIS
Clave=Version.SincroISRecibirRespaldoMatriz
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco

[SincroSSB.ListaEnCaptura]
(Inicio)=Version.SincroSBBOkConservar
Version.SincroSBBOkConservar=Version.SincroSSBModoManual
Version.SincroSSBModoManual=Version.SincroContabilidadMatriz
Version.SincroContabilidadMatriz=Version.SincroSSBRecibirRespaldoMatriz
Version.SincroSSBRecibirRespaldoMatriz=Version.TRCL
Version.TRCL=(Fin)

[Acciones.ActivarSincro]
Nombre=ActivarSincro
Boton=7
NombreEnBoton=S
NombreDesplegar=&Activar Sincro...
GuardarAntes=S
RefrescarDespues=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
Expresion=Asigna(Temp.Texto,NULO)<BR>Dialogo(<T>ActivarSincro<T>)<BR>Si Temp.Texto = <T>SSB<T> Entonces<BR>  Si(no Version:Version.SincroSSBMismaInstancia, Archivo.Eliminar(Directorio.Verificar(Version:Version.RutaCertificados, Verdadero)+<T>\CertificadoSSB_<T>+Version:Version.Sucursal))<BR>  VerComentario( <T>Script para Activar SSB<T>, SQLEnLista(<T>spSincroSSB_Activar<T>))<BR>SiNo<BR>  Si Temp.Texto = <T>IS<T> Entonces<BR>    EJECUTARSQL(<T>EXEC spSincroIS_Activar<T>)<BR>  Fin<BR>Fin
ActivoCondicion=(no Version:Version.SincroSSB) y (no Version:Version.SincroIS)

[Ficha.Version.SincroIS]
Carpeta=Ficha
Clave=Version.SincroIS
Editar=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Ficha.Version.ISDiasResguardoSolicitud]
Carpeta=Ficha
Clave=Version.ISDiasResguardoSolicitud
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=10
ColorFondo=Blanco

[SincroIS.Version.SincroISDBMailPerfil]
Carpeta=SincroIS
Clave=Version.SincroISDBMailPerfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[SincroIS.Version.SincroISDBMailAsunto]
Carpeta=SincroIS
Clave=Version.SincroISDBMailAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80
ColorFondo=Blanco

[Mensaje]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Mensaje (Sincro IS)
Clave=Mensaje
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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
ListaEnCaptura=Version.SincroISDBMailMensaje
AlinearTodaCarpeta=S
CondicionVisible=Version:Version.SincroIS

[Mensaje.Version.SincroISDBMailMensaje]
Carpeta=Mensaje
Clave=Version.SincroISDBMailMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=80x16
ColorFondo=Blanco

[Acciones.SincroISAyuda]
Nombre=SincroISAyuda
Boton=34
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Expresion=Informacion(<T>Se podrán incluir los siguientes campos en el cuerpo<BR><T>&<BR>            <T>del mensaje ó del asunto del correo electrónico que<BR><T>&<BR>            <T>emite la sincronizacion IS en caso de error.<BR><T>&<BR>            <T><BR><T>&<BR>            <T>#IntelisisServiceID# -> ID de Paquete de Sincronización<BR><T>&<BR>            <T>#SubReferencia# -> Tipo de Sincronización<BR><T>&<BR>            <T>#Estatus# -> Estatus actual del paquete de sincronización<BR><T>&<BR>            <T>#IntelisisServiceOk# -> Código de error del paquete de sincronización<BR><T>&<BR>            <T>#IntelisisServiceOkRev# -> Descripción del error<BR><T>&<BR>            <T>#FechaEstatus# -> Fecha de procesamiento del paquete<BR><T>&<BR>            <T>#Conversacion# -> Identificador de la conversación de Sincronización<BR><T>&<BR>            <T>#SincroGUID# -> Identificador único del paquete de sincronización<BR><T>&<BR>            <T>#SucursalOrigen# -> Sucursal origen del paquete<BR><T>&<BR>            <T>#SucursalDestino# -> Sucursal destino del paquete<T>)
VisibleCondicion=Version:Version.SincroIS

[Acciones.SincroISRetraso]
Nombre=SincroISRetraso
Boton=15
NombreDesplegar=&Retraso transmisión
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SincroISRetraso
Activo=S
VisibleCondicion=Version:Version.SincroIS

[Acciones.PerfilDBMail]
Nombre=PerfilDBMail
Boton=84
NombreDesplegar=&Perfil DBMail
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S
GuardarAntes=S
TipoAccion=Formas
ClaveAccion=CFDFlexPerfilDBMail

[Acciones.SincroISConexion]
Nombre=SincroISConexion
Boton=16
NombreDesplegar=Configurar Conexión Sincro IS
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=SincroISTransmisorSucursal
Activo=S
VisibleCondicion=Version:Version.SincroIS

[Acciones.SincroISTrabajo]
Nombre=SincroISTrabajo
Boton=102
NombreDesplegar=Trabajo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SincroISTrabajo
Activo=S
ConCondicion=S
EjecucionCondicion=Asigna(Info.Contacto, <T>SincroIS<T>)
VisibleCondicion=Version:Version.SincroIS

[Acciones.InterfaseAspel]
Nombre=InterfaseAspel
Boton=16
NombreDesplegar=Configurar Conexión SAE/NOI
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=InterfaseAspel
Activo=S
VisibleCondicion=General.InterfazAspel

[CorreoPOP3]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=POP3
Clave=CorreoPOP3
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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

[CorreoPOP3.ListaEnCaptura]
(Inicio)=Version.RecibirCorreoRuta
Version.RecibirCorreoRuta=Version.RecibirCorreoPerfil
Version.RecibirCorreoPerfil=Version.RecibirCorreoRutaComponentePOP
Version.RecibirCorreoRutaComponentePOP=(Fin)

[CorreoPOP3.Version.RecibirCorreoRuta]
Carpeta=CorreoPOP3
Clave=Version.RecibirCorreoRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[CorreoPOP3.Version.RecibirCorreoPerfil]
Carpeta=CorreoPOP3
Clave=Version.RecibirCorreoPerfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[CorreoPOP3.Version.RecibirCorreoRutaComponentePOP]
Carpeta=CorreoPOP3
Clave=Version.RecibirCorreoRutaComponentePOP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[SincroIS.Version.SincroISDropBox]
Carpeta=SincroIS
Clave=Version.SincroISDropBox
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=15
ColorFondo=Blanco

[SincroISDropBox.Version.SincroISDropBoxRuta]
Carpeta=SincroISDropBox
Clave=Version.SincroISDropBoxRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[SincroIS.Version.SincroISDropBoxRuta]
Carpeta=SincroIS
Clave=Version.SincroISDropBoxRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Directorios.Version.DirectorioEmpaquetadorArchivos]
Carpeta=Directorios
Clave=Version.DirectorioEmpaquetadorArchivos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[SincroIS.Version.ISDropBoxDiasResguardoArchivos]
Carpeta=SincroIS
Clave=Version.ISDropBoxDiasResguardoArchivos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[SincroIS.Version.DirectorioEmpaquetadorArchivos]
Carpeta=SincroIS
Clave=Version.DirectorioEmpaquetadorArchivos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=50
ColorFondo=Blanco


[Intelisis MES]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Intelisis Factory
Clave=Intelisis MES
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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

CondicionVisible=General.ProdInterfazINFOR
[Intelisis MES.Version.MESISDBMailPerfil]
Carpeta=Intelisis MES
Clave=Version.MESISDBMailPerfil
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Intelisis MES.Version.MESISDBMailAsunto]
Carpeta=Intelisis MES
Clave=Version.MESISDBMailAsunto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=50x25

[Intelisis MES.Version.MESISDBMailMensaje]
Carpeta=Intelisis MES
Clave=Version.MESISDBMailMensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=80

[Intelisis Factory.ListaEnCaptura]
(Inicio)=Version.RutaIntelisisMES
Version.RutaIntelisisMES=Version.ServidorWEB
Version.ServidorWEB=Version.MESISDBMailPerfil
Version.MESISDBMailPerfil=Version.MESISDBMailAsunto
Version.MESISDBMailAsunto=(Fin)































[Intelisis MES.Version.RutaIntelisisMES]
Carpeta=Intelisis MES
Clave=Version.RutaIntelisisMES
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Intelisis MES.Version.ServidorWEB]
Carpeta=Intelisis MES
Clave=Version.ServidorWEB
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[SincroIS.ListaEnCaptura]
(Inicio)=Version.SincroISRecibirRespaldoMatriz
Version.SincroISRecibirRespaldoMatriz=Version.SincroISDBMailPerfil
Version.SincroISDBMailPerfil=Version.SincroISDBMailAsunto
Version.SincroISDBMailAsunto=Version.TRCL
Version.TRCL=Version.DirectorioEmpaquetadorArchivos
Version.DirectorioEmpaquetadorArchivos=Version.SincroISDropBox
Version.SincroISDropBox=Version.SincroISDropBoxRuta
Version.SincroISDropBoxRuta=Version.ISDropBoxDiasResguardoArchivos
Version.ISDropBoxDiasResguardoArchivos=(Fin)

[SincroIS.Version.TRCL]
Carpeta=SincroIS
Clave=Version.TRCL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S

ColorFondo=Blanco







[Ficha.Version.ContabilidadParalela]
Carpeta=Ficha
Clave=Version.ContabilidadParalela
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco









Tamano=20
[ContabilidadParalela]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Contabilidad Paralela
Clave=ContabilidadParalela
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Version
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



CondicionVisible=Version:Version.ContabilidadParalela y Falso
[ContabilidadParalela.Version.CPBaseLocal]
Carpeta=ContabilidadParalela
Clave=Version.CPBaseLocal
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

EspacioPrevio=S
Tamano=50
[ContabilidadParalela.Version.CPBaseDatos]
Carpeta=ContabilidadParalela
Clave=Version.CPBaseDatos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[ContabilidadParalela.Version.CPURL]
Carpeta=ContabilidadParalela
Clave=Version.CPURL
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco








[ContabilidadParalela.Version.CPCentralizadora]
Carpeta=ContabilidadParalela
Clave=Version.CPCentralizadora
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco

Tamano=40



[Ficha.ListaEnCaptura]
(Inicio)=Version.RedondeoMonetarios
Version.RedondeoMonetarios=Version.Impuesto2BaseImpuesto1
Version.Impuesto2BaseImpuesto1=Version.Retencion2BaseImpuesto1
Version.Retencion2BaseImpuesto1=Version.Impuesto2Info
Version.Impuesto2Info=Version.Impuesto3Info
Version.Impuesto3Info=Version.Peru
Version.Peru=Version.NomLimiteInferior2
Version.NomLimiteInferior2=Version.SituacionFinalAlRegresar
Version.SituacionFinalAlRegresar=Version.RegHist
Version.RegHist=Version.FK
Version.FK=Version.OutlookEstatusNuevo
Version.OutlookEstatusNuevo=Version.NombreCorreoEnLote
Version.NombreCorreoEnLote=Version.SincroSSBMismaInstancia
Version.SincroSSBMismaInstancia=Version.RutaCertificados
Version.RutaCertificados=Version.PuertoSSB
Version.PuertoSSB=Version.SincroSSB
Version.SincroSSB=Version.SincroIS
Version.SincroIS=Version.IPDinamica
Version.IPDinamica=Version.ModuloCentral
Version.ModuloCentral=Version.ISDiasResguardoSolicitud
Version.ISDiasResguardoSolicitud=Version.InterfazExentus
Version.InterfazExentus=Version.AccesoInterfazExentus
Version.AccesoInterfazExentus=Version.InterfazExentus2
Version.InterfazExentus2=Version.ContabilidadParalela
Version.ContabilidadParalela=(Fin)

[Ficha.Version.AccesoInterfazExentus]
Carpeta=Ficha
Clave=Version.AccesoInterfazExentus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.Version.InterfazExentus]
Carpeta=Ficha
Clave=Version.InterfazExentus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
EspacioPrevio=S

[Ficha.Version.InterfazExentus2]
Carpeta=Ficha
Clave=Version.InterfazExentus2
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S


























[Intelisis MES.ListaEnCaptura]
(Inicio)=Version.RutaIntelisisMES
Version.RutaIntelisisMES=Version.ServidorWEB
Version.ServidorWEB=Version.MESISDBMailPerfil
Version.MESISDBMailPerfil=Version.MESISDBMailAsunto
Version.MESISDBMailAsunto=(Fin)
































[ContabilidadParalela.Version.CPUsuario]
Carpeta=ContabilidadParalela
Clave=Version.CPUsuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

EspacioPrevio=S
[ContabilidadParalela.Version.CPContrasena]
Carpeta=ContabilidadParalela
Clave=Version.CPContrasena
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

LineaNueva=S























[ContabilidadParalela.ListaEnCaptura]
(Inicio)=Version.CPCentralizadora
Version.CPCentralizadora=Version.CPUsuario
Version.CPUsuario=Version.CPContrasena
Version.CPContrasena=Version.CPBaseLocal
Version.CPBaseLocal=Version.CPBaseDatos
Version.CPBaseDatos=Version.CPURL
Version.CPURL=(Fin)

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=BaseDatos
BaseDatos=Contrasena
Contrasena=Outlook
Outlook=ModuloCentral
ModuloCentral=SincroSSB
SincroSSB=SincroIS
SincroIS=Mensaje
Mensaje=IPDinamica
IPDinamica=CorreoPOP3
CorreoPOP3=Intelisis MES
Intelisis MES=ContabilidadParalela
ContabilidadParalela=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CacheCola
CacheCola=Replica
Replica=ActivarSincro
ActivarSincro=Certificados
Certificados=Respaldo
Respaldo=CfgRegHist
CfgRegHist=SincroISRetraso
SincroISRetraso=SincroISConexion
SincroISConexion=SincroISAyuda
SincroISAyuda=PerfilDBMail
PerfilDBMail=SincroISTrabajo
SincroISTrabajo=InterfaseAspel
InterfaseAspel=(Fin)
